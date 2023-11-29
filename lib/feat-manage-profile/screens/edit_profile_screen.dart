import 'package:audiory_v0/feat-read/screens/reading/audio_bottom_bar.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/Sex.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/dropdown_button.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../theme/theme_constants.dart';
import 'package:fquery/fquery.dart';

class EditProfileScreen extends StatefulHookWidget {
  final AuthUser? currentUser;
  final Profile? userProfile;
  const EditProfileScreen({super.key, this.currentUser, this.userProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String _selectedDate = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final profileQuery =
        useQuery(['profile'], () => ProfileRepository().fetchProfileByUserId());

    DateTime? datepicked;
    Widget userInfo(Profile? profile) {
      const genderList = Sex.values;
      String formatDate(String? date) {
        //use package intl
        DateTime dateTime = DateTime.parse(date as String);
        return DateFormat('dd/MM/yyyy').format(dateTime);
      }

      Future<void> showdobpicker() async {
        datepicked = await showDatePicker(
            helpText: 'Chọn ngày sinh',
            context: context,
            initialDate: DateTime.tryParse(
                    profile?.dob ?? DateTime(2000, 1, 1).toString()) ??
                DateTime(2000, 1, 1),
            firstDate: DateTime(1933, 1, 1),
            lastDate: DateTime(2017, 1, 1),

            //initial entry : calendar picker or input
            initialEntryMode: DatePickerEntryMode.input,
            confirmText: 'Chọn',
            cancelText: 'Hủy',
            fieldHintText: '01/01/2002',
            fieldLabelText: 'Nhập ngày',
            errorInvalidText: 'Năm sinh trong khoảng 1933-2017',
            errorFormatText: 'Lỗi định dạng (dd/MM/yyyy)',
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme(
                      primary: appColors.primaryBase,
                      onPrimary: appColors.skyLightest,
                      secondary: appColors.primaryBase,
                      onSecondary: appColors.primaryBase,
                      error: Colors.red,
                      onError: Colors.red,
                      background: appColors.primaryBase,
                      onBackground: appColors.primaryBase,
                      surface: appColors.skyLightest,
                      onSurface: appColors.primaryBase,
                      brightness: Brightness.light),
                  buttonBarTheme: const ButtonBarThemeData(
                      buttonTextTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            });
        // ignore: unrelated_type_equality_checks
        if (datepicked != null) {
          print('DATE $datepicked');
          setState(() {
            _selectedDate = appFormatDate(datepicked?.toString());
          });
        }
      }

      Widget timePickerWidget(
          {String? defaultDob = '2000-01-01T01:00:00+07:00'}) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Ngày sinh",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                // Flexible(
                //   child: GestureDetector(
                //       onTap: () {
                //         showdobpicker();
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Icon(
                //           Icons.calendar_today,
                //           color: appColors.skyDark,
                //           size: 20,
                //         ),
                //       )),
                // ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextInputField(
                textInputType: TextInputType.datetime,
                isRequired: false,
                name: 'dob',
                suffixIcon: GestureDetector(
                    onTap: () {
                      showdobpicker();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: appColors.skyDark,
                        size: 20,
                      ),
                    )),
                initialValue: _selectedDate != ''
                    ? _selectedDate
                    : formatDate(profile?.dob),
                hintText: _selectedDate,
                hintTextStyle: TextStyle(color: appColors.inkBase),
                validator: (value) {
                  if ((value?.allMatches(
                              r'^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\\d\\d$') ??
                          true) ==
                      (false)) {
                    print('wrogn');
                    return 'Nhập đúng định dạng dd/MM/yyyy';
                  }
                }),
            const SizedBox(
              height: 16,
            )
          ],
        );
      }

      //put a single child scroll view in center widget
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // <-- SEE HERE
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        FormBuilderImagePicker(
                          initialValue: profile?.avatarUrl != null &&
                                  profile?.avatarUrl != ''
                              ? [profile?.avatarUrl ?? '']
                              : null,
                          iconColor: appColors.inkBase,
                          placeholderWidget: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  height: size.width / 3,
                                  width: size.height / 3,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: appColors.skyLighter),
                                ),
                                Positioned(
                                    child: Icon(
                                  Icons.image,
                                  color: appColors.inkLight,
                                ))
                              ]),

                          transformImageWidget: (context, displayImage) =>
                              Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  width: size.width / 3,
                                  height: size.width / 3,
                                  child: displayImage,
                                )),
                          ),
                          showDecoration: true,
                          galleryIcon: Icon(
                            Icons.image,
                            color: appColors.primaryBase,
                          ),
                          galleryLabel: const Text('Thư viện ảnh'),

                          fit: BoxFit.cover,
                          backgroundColor: appColors.skyLighter,
                          availableImageSources: const [
                            ImageSourceOption.gallery
                          ], //only gallery
                          name: 'photos',
                          maxImages: 1,
                        ),
                      ]),
                    ),
                    AppTextInputField(
                      name: 'full_name',
                      label: 'Tên gọi',
                      hintText: 'Nhập tên ',
                      initialValue: profile?.fullName,
                    ),

                    //dob
                    timePickerWidget(defaultDob: profile?.dob ?? ''),
                    //sex

                    AppDropdownButton(
                        label: 'Giới tính ',
                        name: 'sex',
                        list: genderList,
                        initValue: profile?.sex ?? genderList[0].name,
                        itemsList: List.generate(
                            genderList.length,
                            (index) => DropdownMenuItem(
                                value: genderList[index].name, //required
                                child: Text(genderList[index].displayTitle)))),
                    const SizedBox(
                      height: 16,
                    ),

                    AppTextInputField(
                      name: 'facebook_url',
                      initialValue: profile?.facebookUrl == ''
                          ? ''
                          : profile?.facebookUrl,
                      label: 'Trang facebook',
                      hintText: 'https://www.facebook.com',
                    ),
                    AppTextInputField(
                      isTextArea: true,
                      minLines: 2,
                      maxLengthCharacters: 256,
                      name: 'description',
                      label: 'Giới thiệu bản thân',
                      hintText: 'Đôi ba dòng về bạn',
                      initialValue: profile?.description == ''
                          ? ''
                          : profile?.description ?? '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: SizedBox(
                          width: size.width / 2.3,
                          child: AppIconButton(
                            onPressed: () async {
                              _formKey.currentState?.reset();
                            },
                            isOutlined: true,
                            bgColor: appColors.skyLightest,
                            color: appColors.primaryBase,
                            title: 'Đặt lại',
                          ),
                        )),
                        SizedBox(
                            width: size.width / 2.3,
                            child: AppIconButton(
                              onPressed: () async {
                                final validationSuccess =
                                    _formKey.currentState?.validate();
                                if (validationSuccess == true) {
                                  _formKey.currentState?.save();

                                  //create request body
                                  Map<String, String> body = <String, String>{};

                                  body['full_name'] = _formKey
                                      .currentState?.fields['full_name']?.value;
                                  body['sex'] = _formKey
                                      .currentState?.fields['sex']?.value;
                                  body['description'] = _formKey.currentState
                                      ?.fields['description']?.value;
                                  body['facebook_url'] = _formKey.currentState
                                      ?.fields['facebook_url']?.value;
                                  final parsedDate = DateTime.tryParse('');
                                  // body['dob'] =
                                  //     parsedDate?.toUtc().toIso8601String() ??
                                  //         '';

                                  //edit profile
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      });

                                  Profile? newProfile =
                                      await ProfileRepository().updateProfile(
                                    _formKey
                                        .currentState?.fields['photos']?.value,
                                    body,
                                  );
                                  print('PROFILE ${newProfile}');
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                  profileQuery.refetch();
                                  newProfile == null
                                      // ignore: use_build_context_synchronously
                                      ? AppSnackBar.buildSnackbar(
                                          context,
                                          'Chỉnh sửa gặp lỗi',
                                          null,
                                          SnackBarType.error)
                                      // ignore: use_build_context_synchronously
                                      : AppSnackBar.buildSnackbar(context,
                                          'Chỉnh sửa thành công', 'Ẩn', null);
                                }
                              },
                              title: 'Cập nhật',
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        'Sửa hồ sơ',
        style: textTheme.headlineMedium?.copyWith(color: appColors.inkBase),
      )),
      body: Skeletonizer(
          enabled: profileQuery.isFetching || profileQuery.data == null,
          child: profileQuery.data != null
              ? userInfo(profileQuery.data)
              : const Skeletonizer(
                  enabled: true,
                  child: Center(
                    child: Column(children: [
                      AppAvatarImage(
                        size: 90,
                        url: '',
                      ),
                      AppTextInputField(
                        name: 'helo',
                        label: 'helo',
                      )
                    ]),
                  ))),
      floatingActionButton: const AudioBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
