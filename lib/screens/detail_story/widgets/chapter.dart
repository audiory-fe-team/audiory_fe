import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  final String title;
  final String time;
  const ChapterItem({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF72777A),
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '20 giờ trước',
            style: TextStyle(
              color: Color(0xFF72777A),
              fontSize: 10,
              fontStyle: FontStyle.italic,
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
