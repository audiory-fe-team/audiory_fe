import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../theme/theme_constants.dart';
import '../../../../repositories/auth_repository.dart';

class FlowOneScreen extends StatefulWidget {
  final Map<String, String>? signUpBody;

  const FlowOneScreen({super.key, this.signUpBody = const {}});

  @override
  State<FlowOneScreen> createState() => _FlowOneScreenState();
}

class _FlowOneScreenState extends State<FlowOneScreen> {
  var isResetCountdown = false;
  var countDownTime = const Duration(
    minutes: 1,
    seconds: 0,
  );
  final remainTime = 0;
  var duration = DateTime.now().add(const Duration(minutes: 1));
  var isEnd = false;
  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.digitsOnly, // Allows only digits
    LengthLimitingTextInputFormatter(4), // Limits to two digits
  ];

  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 4,
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
                            width: size.width / 1.2,
                            child: Text(
                              "Mã xác nhận đã được gửi đến email ${widget.signUpBody?['email']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: appColors.inkBase,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
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
                          FormBuilder(
                            key: _formKey,
                            child: TextFormField(
                              inputFormatters: inputFormatters,
                              keyboardType: TextInputType.number,
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
                          ),
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: AppIconButton(
                              title: "Tiếp tục",
                              color: Colors.white,
                              bgColor: const Color(0xFF439A97),
                              onPressed: () async {
                                print('is end');
                                if (bool.parse(
                                    widget.signUpBody?['isForgotPass'] ??
                                        'false')) {
                                  try {
                                    await AuthRepository().checkResetPassword(
                                        resetToken: codeController.text);
                                    // ignore: use_build_context_synchronously
                                    context.push('/resetPassword', extra: {
                                      'resetToken': codeController.text
                                    });
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    AppSnackBar.buildTopSnackBar(
                                        context,
                                        'Sai mã xác nhận',
                                        null,
                                        SnackBarType.error);
                                  }
                                } else {
                                  try {
                                    Profile? response = await AuthRepository()
                                        .signUp(
                                            email:
                                                widget.signUpBody?['email'] ??
                                                    '',
                                            password: widget
                                                    .signUpBody?['password'] ??
                                                '',
                                            username: widget
                                                    .signUpBody?['username'] ??
                                                '',
                                            fullname: widget
                                                    .signUpBody?['username'] ??
                                                '',
                                            code: codeController.text);

                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    // ignore: use_build_context_synchronously
                                    context.pushNamed('flowTwo', extra: {
                                      'userId': response?.id ??
                                          'f374430d-5b57-11ee-9514-0242ac1c0002'
                                    });
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    AppSnackBar.buildTopSnackBar(
                                        context,
                                        'Sai mã xác nhận',
                                        null,
                                        SnackBarType.error);
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (isEnd==true) {
                                final result = await AuthRepository()
                                    .verifyEmail(
                                        email:
                                            widget.signUpBody?['email'] ?? '');
                                if (result == 200) {
                                  // ignore: use_build_context_synchronously
                                  AppSnackBar.buildTopSnackBar(
                                      context,
                                      'Gửi lại mã thành công',
                                      null,
                                      SnackBarType.success);
                                  setState(() {
                                    duration = DateTime.now()
                                        .add(const Duration(minutes: 1));
                                  });
                                }
                              } else {
                                AppSnackBar.buildTopSnackBar(
                                    context,
                                    'Đợi 1 phút để gửi lại mã',
                                    null,
                                    SnackBarType.info);
                              }
                            },
                            child: Center(
                                child: Text('Gửi lại mã',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                          ),
                          Center(
                            child: TimerCountdown(
                              onTick: (remainingTime) {},
                              format: CountDownTimerFormat.secondsOnly,
                              descriptionTextStyle:
                                  const TextStyle(color: Colors.transparent),
                              timeTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              endTime: duration,
                              spacerWidth: 0,
                              onEnd: () {
                                setState(() {
                                  isEnd = true;
                                });
                              },
                              secondsDescription: 's',
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),
        ));
  }
}
