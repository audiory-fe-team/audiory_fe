import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class StoryCardOverView extends StatelessWidget {
  final String? coverUrl;
  final String title;

  const StoryCardOverView({this.title = '', this.coverUrl = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          GoRouter.of(context).go("/story/1/chapter/1");
        },
        child: Container(
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
        ));
  }
}
