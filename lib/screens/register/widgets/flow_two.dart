import 'package:audiory_v0/screens/register/widgets/flow_three.dart';
import 'package:audiory_v0/widgets/buttons/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:audiory_v0/screens/register/widgets/register_body.dart';

class FlowTwoScreen extends StatefulWidget {
  const FlowTwoScreen({super.key});

  @override
  State<FlowTwoScreen> createState() => _FlowTwoScreenState();
}

class _FlowTwoScreenState extends State<FlowTwoScreen> {
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
                      child: Text("Bạn hứng thú với vai trò nào?",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Color(0xff000000))),
                    )),
                Expanded(
                  flex: 9,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    height: 180,
                                    child: Image(
                                        height: double.maxFinite,
                                        image: AssetImage(
                                            'assets/images/reading_girl.png'))),
                              ]),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ActionButton(
                              title: 'Đọc',
                              color: Colors.black,
                              bgColor: Colors.white,
                              onPressed: () => {},
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                            ActionButton(
                              title: 'Sáng tác',
                              color: Colors.black,
                              bgColor: Colors.white,
                              onPressed: () => {},
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                            ActionButton(
                              title: 'Đọc và sáng tác',
                              color: Colors.black,
                              bgColor: Colors.white,
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ]),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          title: "Tiếp tục",
                          color: Colors.white,
                          bgColor: Color(0xFF439A97),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FlowThreeScreen()),
                            );
                          },
                        )
                      ],
                    )),
              ]),
        ));
  }
}
