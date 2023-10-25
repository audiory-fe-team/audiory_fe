import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/Sex.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/dropdown_button.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  String _selectedDate = (String? date) {
    //use package intl
    DateTime dateTime = DateTime.parse(date as String);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }(DateTime(2000, 1, 1).toIso8601String());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    // final userProfile = ref.watch(userProfileAllDataProvider);
    final profileQuery = useQuery(
        ['profile'],
        () => ProfileRepository()
            .fetchUserProfileByUserId(widget.currentUser?.id as String));

    DateTime? datepicked;

    Widget userInfo() {
      String formatDate(String? date) {
        //use package intl
        DateTime dateTime = DateTime.parse(date as String);
        return DateFormat('dd/MM/yyyy').format(dateTime);
      }

      const genderList = Sex.values;

      Future<void> showdobpicker() async {
        datepicked = await showDatePicker(
            helpText: 'Chọn ngày sinh',
            context: context,
            initialDate: DateTime(2000, 1, 1),
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
                      surface: appColors.primaryBase,
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
          setState(() {
            _selectedDate = formatDate(datepicked!.toString());
          });
        }
      }

      Widget timePickerWidget() {
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
                Flexible(
                  child: GestureDetector(
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
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextInputField(
              isRequired: false,
              isDisabled: false,
              name: 'dob',
              hintText: _selectedDate,
              hintTextStyle: TextStyle(color: appColors.inkBase),
            ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      context.push('/profile');
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(400),
                        child: AppImage(
                            url: widget.userProfile?.avatarUrl,
                            width: size.width / 3.5,
                            height: size.width / 3.5,
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // <-- SEE HERE
                  children: [
                    AppTextInputField(
                      name: 'full_name',
                      label: 'Tên gọi',
                      hintText: 'Nhập tên ',
                      initialValue: profileQuery.data?.fullName,
                    ),
                    //dob
                    timePickerWidget(),
                    //sex
                    AppDropdownButton(
                        label: 'Giới tính ',
                        name: 'sex',
                        list: genderList,
                        initValue: genderList[0].name,
                        itemsList: List.generate(
                            genderList.length,
                            (index) => DropdownMenuItem(
                                value: genderList[index].name, //required
                                child: Text(genderList[index].displayTitle)))),
                    const SizedBox(
                      height: 16,
                    ),

                    const AppTextInputField(
                      name: 'website',
                      label: 'Trang web cá nhân',
                      hintText: 'https://www.facebook.com',
                    ),
                    const AppTextInputField(
                      isTextArea: true,
                      minLines: 5,
                      maxLengthCharacters: 256,
                      name: 'description',
                      label: 'Giới thiệu bản thân',
                      hintText: 'Đôi ba dòng về bạn',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: SizedBox(
                          width: size.width / 2.5,
                          child: AppIconButton(
                            onPressed: () {},
                            isOutlined: true,
                            bgColor: appColors.skyLightest,
                            color: appColors.primaryBase,
                            title: 'Hủy',
                          ),
                        )),
                        SizedBox(
                            width: size.width / 2.5,
                            child: AppIconButton(
                              onPressed: () async {
                                final validationSuccess =
                                    _formKey.currentState!.validate();
                                if (validationSuccess) {
                                  _formKey.currentState!.save();
                                }

                                if (kDebugMode) {
                                  print('FORM ');
                                  print(_formKey.currentState!.value);
                                }

                                //create request body
                                Map<String, String> body = <String, String>{};

                                body['full_name'] = _formKey
                                    .currentState!.fields['full_name']?.value;
                                body['sex'] =
                                    _formKey.currentState!.fields['sex']?.value;
                                body['description'] = _formKey
                                    .currentState!.fields['description']?.value;
                                body['facebook_url'] = _formKey
                                    .currentState!.fields['website']?.value;
                                final parsedDate = DateFormat('dd/MM/yyyy')
                                    .parse(_selectedDate);
                                body['dob'] =
                                    parsedDate.toUtc().toIso8601String();

                                print('BODY ${body}');

                                //edit profile
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    });

                                Profile? newProfile =
                                    await ProfileRepository().updateProfile(
                                  '',
                                  body,
                                );
                                print('PROFILE ${newProfile}');
                                if (context.mounted) {
                                  context.pop();
                                }

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
                              },
                              icon: null,
                              title: 'Lưu',
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
      body: userInfo(),
    );
  }
}
