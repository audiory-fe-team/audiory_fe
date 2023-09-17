import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme_constants.dart';
import '../../../repositories/auth_repository.dart';

class FlowTwoScreen extends StatefulWidget {
  final Map<String, String>? signUpBody;

  const FlowTwoScreen({super.key, this.signUpBody});

  @override
  State<FlowTwoScreen> createState() => _FlowTwoScreenState();
}

class _FlowTwoScreenState extends State<FlowTwoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
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
                                print('eMAIL ${widget.signUpBody?['email']}');

                                print('body ${widget.signUpBody}');

                                final response = await AuthRepository().signUp(
                                    email:
                                        widget.signUpBody?['email'] as String,
                                    password: widget.signUpBody?['password']
                                        as String,
                                    username: widget.signUpBody?['username']
                                        as String,
                                    fullname: widget.signUpBody?['username']
                                        as String,
                                    code: codeController.text);

                                print(response);
                                FocusManager.instance.primaryFocus?.unfocus();

                                if (response == 200) {
                                  _displaySnackBar('Tạo acc thành công');
                                  // ignore: use_build_context_synchronously
                                  context.go('/login');
                                } else {
                                  _displaySnackBar('Sai mã xác nhận');
                                  codeController.text = '';
                                }

                                // context.push('/flowFour');
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
