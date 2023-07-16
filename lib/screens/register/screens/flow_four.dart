import 'package:audiory_v0/screens/register/widgets/flow_four.dart';
import 'package:flutter/material.dart';
import 'package:audiory_v0/widgets/outlined_button.dart';

class FLowFourScreen extends StatefulWidget {
  const FLowFourScreen({super.key});

  @override
  State<FLowFourScreen> createState() => _FLowFourScreenState();
}

class _FLowFourScreenState extends State<FLowFourScreen> {
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
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
          height: size.height,
          width: size.width,
          // decoration:
          //     const BoxDecoration(color: Color.fromARGB(70, 244, 67, 54)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 2,
                child: Center(
                    child: Column(
                  children: [
                    Text("Hoàn tất hồ sơ của bạn",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Color(0xff000000))),
                    Text(
                        "Đừng lo, chỉ mình bạn có thể thấy thông tin cá nhân của mình",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.normal)),
                  ],
                ))),
            Expanded(
                flex: 14,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipOval(
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(28), // Image radius
                                child: Image(
                                    height: double.maxFinite,
                                    image: AssetImage(
                                        'assets/images/default_avt.png'))),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Họ và tên",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 6.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      isDense: true,
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
                                              vertical: 10.0, horizontal: 24),
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
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Số điện thoại",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 6.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      isDense: true,
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
                                              vertical: 10.0, horizontal: 24),
                                      labelText: "012345678",
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
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Ngày sinh",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 6.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      isDense: true,
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
                                              vertical: 10.0, horizontal: 24),
                                      labelText: "19/12/2002",
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
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Giới thiệu bản thân",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 6.0,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: Color(0xFF439A97),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: Color(0xFF439A97),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: Color(0xFF439A97),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 212, 212)),
                                      fillColor: Colors.white70,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 24),
                                      labelText: "Đôi nét về các hạ",
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
                      ]),
                )),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlineBtn(
                      text: "Bỏ qua",
                      size: 150,
                      color: Colors.black,
                      bgColor: Colors.white,
                      onPress: () => {},
                    ),
                    OutlineBtn(
                      text: "Tiếp tục",
                      size: 150,
                      color: Colors.white,
                      bgColor: Color(0xFF439A97),
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FLowFourScreen()),
                        );
                      },
                    )
                  ],
                )),
          ]),
        ));
  }
}
