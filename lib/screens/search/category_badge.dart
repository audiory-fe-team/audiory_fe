import 'package:flutter/material.dart';

class CategoryBadge extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoryBadge({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 47,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 46.88,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0x1125282B), Colors.black],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          SizedBox(
            width: 86,
            child: Text(
              'Romantic',
              style: TextStyle(
                color: Color(0xFFFFFDFD),
                fontSize: 16,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
