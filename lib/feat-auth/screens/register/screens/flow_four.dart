import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../theme/theme_constants.dart';

class FLowFourScreen extends StatefulWidget {
  final String userId;
  const FLowFourScreen({super.key, required this.userId});

  @override
  State<FLowFourScreen> createState() => _FLowFourScreenState();
}

class _FLowFourScreenState extends State<FLowFourScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hoàn tất hồ sơ của bạn",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: appColors.inkDarkest)),
                  Text(
                      "Đừng lo, chỉ mình bạn có thể thấy thông tin cá nhân của mình",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.normal)),
                ],
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100),
                            child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  FormBuilderImagePicker(
                                    iconColor: appColors.inkBase,

                                    showDecoration: false,
                                    // placeholderImage: const NetworkImage(
                                    //     'https://www.pngitem.com/pimgs/m/421-4213053_default-avatar-icon-hd-png-download.png'),
                                    galleryIcon: Icon(
                                      Icons.image,
                                      color: appColors.primaryBase,
                                    ),
                                    galleryLabel: const Text('Thư viện ảnh'),

                                    // fit: BoxFit.fill,
                                    // validator: FormBuilderValidators.required(),
                                    backgroundColor: appColors.skyLighter,

                                    availableImageSources: const [
                                      ImageSourceOption.gallery
                                    ], //only gallery
                                    name: 'photos',
                                    // decoration: const InputDecoration(labelText: 'Pick Photos'),
                                    maxImages: 1,
                                  ),
                                  // SizedBox(
                                  //   child: Container(
                                  //       padding: const EdgeInsets.all(10),
                                  //       decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(16.0),
                                  //         color: appColors.primaryLightest,
                                  //       ),
                                  //       child: Icon(
                                  //         Icons.edit,
                                  //         color: appColors.primaryBase,
                                  //       )),
                                  // )
                                ]),
                          ),
                        ],
                      ),
                      // Center(
                      //   child: Material(
                      //     child: InkWell(
                      //       onTap: () async {},
                      //       customBorder: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(100.0),
                      //       ),
                      //       child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(100.0),
                      //           child: Image.network(
                      //             'https://img.freepik.com/premium-vector/people-saving-money_24908-51569.jpg?w=2000',
                      //             width: size.width / 3.5,
                      //             height: size.width / 3.5,
                      //             errorBuilder:
                      //                 (context, error, stackTrace) =>
                      //                     Image.network(
                      //               'https://img.freepik.com/premium-vector/people-saving-money_24908-51569.jpg?w=2000',
                      //               width: size.width / 3.5,
                      //               height: size.width / 3.5,
                      //             ),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      const AppTextInputField(
                        name: 'full_name',
                        label: 'Họ và tên',
                        hintText: 'Nhập họ và tên',
                      ),
                      const AppTextInputField(
                        name: 'description',
                        label: 'Giới thiệu',
                        hintText: 'Đôi lời về các hạ',
                        isTextArea: true,
                        maxLengthCharacters: 256,
                        minLines: 5,
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: AppIconButton(
                      title: "Bỏ qua",
                      color: Colors.black,
                      bgColor: Colors.white,
                      onPressed: () {
                        AppSnackBar.buildSnackbar(context, 'Hoàn tất đăng ký',
                            null, SnackBarType.success);
                        context.push('/login');
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: AppIconButton(
                      title: "Tiếp tục",
                      color: Colors.white,
                      bgColor: appColors.primaryBase,
                      onPressed: () async {
                        if (_formKey.currentState?.isValid == true) {
                          _formKey.currentState!.save();

                          Map<String, String> body = {};

                          body['full_name'] =
                              _formKey.currentState!.fields['full_name']?.value;
                          body['description'] = _formKey
                              .currentState!.fields['description']?.value;

                          //update new user data
                          Profile? updatedProfile = await ProfileRepository()
                              .updateNewUserProfile(
                                  _formKey
                                      .currentState!.fields['photos']?.value,
                                  body,
                                  widget.userId);

                          // ignore: use_build_context_synchronously
                          AppSnackBar.buildSnackbar(context, 'Hoàn tất đăng ký',
                              null, SnackBarType.success);
                          // ignore: use_build_context_synchronously
                          context.push('/login');
                        }
                      },
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
