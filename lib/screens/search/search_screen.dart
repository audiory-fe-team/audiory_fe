import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.amber,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: const CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/user-avatar.jpg'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                      height: 10,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Xin chào',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        print('haha');
                      },
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/icons/notification on.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ]),
        )),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: ListView(
            children: [],
          )),
    );
  }
}

class HomeStoryCard extends StatelessWidget {
  final String? coverUrl;
  final String title;

  const HomeStoryCard({this.title = '', this.coverUrl = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 95,
            height: 135,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(this.coverUrl ?? ''),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 95,
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    this.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF404446),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
