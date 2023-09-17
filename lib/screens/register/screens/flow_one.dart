import 'package:audiory_v0/screens/register/screens/flow_two.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/buttons/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlowOneScreen extends StatefulWidget {
  const FlowOneScreen({super.key});

  @override
  State<FlowOneScreen> createState() => _FlowOneScreenState();
}

class _FlowOneScreenState extends State<FlowOneScreen> {
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
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: size.height,
          width: size.width,
          // decoration:
          //     const BoxDecoration(color: Color.fromARGB(70, 244, 67, 54)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chọn giới tính của bạn*",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: const Color(0xff000000))),
                    Text("Chọn giới tính để có gợi ý truyện phù hợp",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: const Color(0xFF72777A))),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("Tôi là nam"),
                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("Tôi là nữ"),
                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("Tôi không muốn nói"),
                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ]),
            ),
            Expanded(
              flex: 4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chọn độ tuổi của bạn*",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: const Color(0xff000000))),
                    Text("Chọn độ tuổi để có gợi ý truyện phù hợp",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: const Color(0xFF72777A))),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineBtn(
                          text: '<17',
                          size: 100,
                          color: Colors.black,
                          bgColor: Colors.white,
                          onPress: () => {},
                        ),
                        OutlineBtn(
                          text: '18-21',
                          size: 100,
                          color: Colors.black,
                          bgColor: Colors.white,
                          onPress: () => {},
                        ),
                        OutlineBtn(
                          text: '21+',
                          size: 100,
                          color: Colors.black,
                          bgColor: Colors.white,
                          onPress: () => {},
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 100,
                                child: Image(
                                    height: double.maxFinite,
                                    image: AssetImage(
                                        'assets/images/skate_man.png'))),
                          ]),
                    )
                  ]),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: AppIconButton(
                        title: "Bỏ qua",
                        color: Colors.black,
                        bgColor: Colors.white,
                        onPressed: () {
                          context.go('/flowThree');
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: AppIconButton(
                        title: "Tiếp tục",
                        color: Colors.white,
                        bgColor: const Color(0xFF439A97),
                        onPressed: () {
                          context.go('/flowThree');
                        },
                      ),
                    )
                  ],
                )),
          ]),
        ));
  }
}
