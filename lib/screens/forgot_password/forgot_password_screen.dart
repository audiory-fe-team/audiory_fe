import 'package:audiory_v0/widgets/buttons/filled_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? gender;
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: Container(
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
                    flex: 1,
                    child: Center(
                        child: Column(
                      children: [
                        Text("Nhập mã xác nhận",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Color(0xff000000))),
                        Wrap(
                          children: [
                            Text(
                                "Mã xác nhận đã được gửi đến email dongmy@gmail.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal)),
                          ],
                        )
                      ],
                    ))),
                Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text("Gửi lại mã",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodyMedium
                        //         ?.copyWith(
                        //             color: Color(0xff000000),
                        //             fontWeight: FontWeight.bold)),
                        AppFilledButton(
                            title: 'Tiếp tục',
                            color: Colors.white,
                            bgColor: Color(0xFF439A97),
                            onPressed: () => {})
                      ],
                    )),
              ]),
        ));
  }
}
