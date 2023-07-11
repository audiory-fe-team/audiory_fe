import 'package:audiory_v0/screens/register/widgets/flow_four.dart';
import 'package:audiory_v0/widgets/buttons/outlined_button.dart';
import 'package:flutter/material.dart';

class FlowThreeScreen extends StatefulWidget {
  const FlowThreeScreen({super.key});

  @override
  State<FlowThreeScreen> createState() => _FlowThreeScreenState();
}

class _FlowThreeScreenState extends State<FlowThreeScreen> {
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
                    Text("Thể loại yêu thích",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Color(0xff000000))),
                    Text("Đây là phần tùy chọn, bạn có thể bỏ qua chúng",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.normal)),
                  ],
                ))),
            Expanded(
                flex: 11,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 22,
                          runSpacing: 20,
                          children: [
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 100,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                            Container(
                              // decoration: new BoxDecoration(
                              //   borderRadius: new BorderRadius.circular(16.0),
                              //   color: Colors.green,
                              // ),
                              width: 90,
                              height: 140,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image(
                                              height: double.maxFinite,
                                              image: AssetImage(
                                                  'assets/images/category.png'))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0)),
                                    Center(
                                      child: Text('Lãng mạn'),
                                    )
                                  ]),
                            ),
                          ],
                        ),
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
