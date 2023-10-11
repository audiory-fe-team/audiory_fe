import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme_constants.dart';
import '../../../repositories/auth_repository.dart';

class FlowOneScreen extends StatefulWidget {
  final Map<String, String>? signUpBody;

  const FlowOneScreen({super.key, this.signUpBody});

  @override
  State<FlowOneScreen> createState() => _FlowOneScreenState();
}

class _FlowOneScreenState extends State<FlowOneScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  void _displaySnackBar(String content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    AppSnackBar.buildSnackbar(context, content, null, SnackBarType.error);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    String? gender;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: SizedBox(
          // margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
          height: size.height,
          width: size.width,
          // decoration:
          //     const BoxDecoration(color: Color.fromARGB(70, 244, 67, 54)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Nhập mã xác nhận?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: const Color(0xff000000))),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: size.width / 1.5,
                            child: Text(
                              "Mã xác nhận đã được gửi đến email ${widget.signUpBody?['email']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: appColors.inkBase,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 9,
                  child: Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            maxLength: 4,
                            controller: codeController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF439A97),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xFF439A97),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 228, 212, 212),
                                fontSize: 24,
                                fontFamily: 'Source San Pro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.06,
                              ),
                              fillColor: Colors.white70,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 24.0),
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: AppIconButton(
                              title: "Tiếp tục",
                              color: Colors.white,
                              bgColor: const Color(0xFF439A97),
                              onPressed: () async {
                                if (kDebugMode) {
                                  print('body ${widget.signUpBody}');
                                }

                                Profile? response = await AuthRepository()
                                    .signUp(
                                        email: widget.signUpBody?['email']
                                            as String,
                                        password: widget.signUpBody?['password']
                                            as String,
                                        username: widget.signUpBody?['username']
                                            as String,
                                        fullname: widget.signUpBody?['username']
                                            as String,
                                        code: codeController.text);

                                if (kDebugMode) {
                                  print(response);
                                }
                                FocusManager.instance.primaryFocus?.unfocus();

                                // if (response != null) {
                                //   // ignore: use_build_context_synchronously
                                //   context.pushNamed('flowTwo',
                                //       extra: {'userId': response.id ?? ''});
                                // } else {
                                //   // ignore: use_build_context_synchronously
                                //   AppSnackBar.buildSnackbar(
                                //       context,
                                //       'Vui lòng nhập lại mã xác nhận',
                                //       null,
                                //       SnackBarType.error);
                                // }
                                // ignore: use_build_context_synchronously
                                context.pushNamed('flowTwo', extra: {
                                  'userId': response?.id ??
                                      'f374430d-5b57-11ee-9514-0242ac1c0002'
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await AuthRepository().verifyEmail(
                                  email: widget.signUpBody?['email'] as String);
                              if (result == 200) {
                                _displaySnackBar('Gửi mã thành công');
                              }
                            },
                            child: Center(
                                child: Text('Gửi lại mã',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                          )
                        ]),
                  ),
                ),
              ]),
        ));
  }
}
