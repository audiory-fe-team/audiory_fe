import 'package:audiory_v0/screens/login/login_screen.dart';
import 'package:audiory_v0/screens/register/widgets/flow_one.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/filled_button.dart';
import '../../../widgets/rounded_button.dart';

class RegisterBodyScreen extends StatefulWidget {
  const RegisterBodyScreen({super.key});

  @override
  State<RegisterBodyScreen> createState() => _RegisterBodyScreenState();
}

class _RegisterBodyScreenState extends State<RegisterBodyScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? isChecked = false;

  void press() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(),
        // ),
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Đăng ký",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Color(0xff000000))),
                      Text("Tạo một tài khoản để bắt đầu",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Color(0xFF72777A))),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Họ và tên",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Color(0xFF439A97),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80)),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Color(0xFF439A97),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Color(0xFF439A97),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80)),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 228, 212, 212)),
                                        fillColor: Colors.white70,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 24),
                                        labelText: "Tên đăng nhập",
                                        focusColor: Colors.black12),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Nhập tên đăng nhập của bạn';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ],
                              )),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Địa chỉ email",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: emailController,
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
                                      borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Color(0xFF439A97),
                                      ),
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
                                        color:
                                            Color.fromARGB(255, 228, 212, 212)),
                                    fillColor: Colors.white70,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 24),
                                    labelText: "Email",
                                    focusColor: Colors.black12),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Nhập tên đăng nhập của bạn';
                                //   }
                                //   return null;
                                // },
                              ),
                            ],
                          )),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Mật khẩu",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF439A97),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF439A97),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 228, 212, 212),
                                            fontSize: 24,
                                            fontFamily: 'Source San Pro',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.06,
                                          ),
                                          fillColor: Colors.white70,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 24.0),
                                          labelText: "Mật khẩu"),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Nhập mật khẩu của bạn';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF439A97),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Color(0xFF439A97),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80)),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 228, 212, 212),
                                            fontSize: 24,
                                            fontFamily: 'Source San Pro',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.06,
                                          ),
                                          fillColor: Colors.white70,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 24.0),
                                          labelText: "Xác nhận mật khẩu"),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Nhập mật khẩu của bạn';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ])),
                          Container(
                              width: 343,
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Tôi đã đọc và đồng ý với',
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 10.0),
                                  ),
                                  Text(
                                    ' các điều khoản và điều kiện ',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0,
                                            color: Color.fromARGB(
                                                255, 98, 139, 138)),
                                  )
                                ],
                              )),
                          Container(
                            width: double.infinity,
                            height: 48,
                            child: ActionButton(
                              title: 'Đăng ký',
                              color: Colors.white,
                              bgColor: Color(0xFF439A97),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FlowOneScreen()),
                                )
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Đã có tài khoản?',
                                  textAlign: TextAlign.right,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()))
                                  },
                                  child: Text(
                                    'Đăng nhập',
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF439A97)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
