import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String? coverUrl;
  final String title;

  const StoryCard({this.title = '', this.coverUrl = ''});

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
