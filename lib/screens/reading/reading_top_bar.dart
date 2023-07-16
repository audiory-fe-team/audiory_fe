import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const ReadingTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            color: Colors.white,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/left-arrow.svg',
                      width: 24, height: 24),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Text('Trường hợp kỳ lạ của Tiến sĩ Peppa Pig',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall)),
                  const SizedBox(width: 4),
                  SvgPicture.asset('assets/icons/more-vertical.svg',
                      width: 24, height: 24),
                ])));
  }
}
