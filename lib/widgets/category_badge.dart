import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RankingListBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const RankingListBadge({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: selected
            ? const Color(0xFF439A97)
            : Color.fromARGB(255, 206, 206, 206),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  selected ? const Color(0xFFFFFDFD) : const Color(0xFF404446),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
