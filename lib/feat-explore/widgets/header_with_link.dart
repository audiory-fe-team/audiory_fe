import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HeaderWithLink extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? link;

  const HeaderWithLink({super.key, this.icon, required this.title, this.link});

  @override
  Widget build(BuildContext context) {
    // final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child:
                          Skeleton.replace(width: 20, height: 20, child: icon!))
                  : const SizedBox(),
              SizedBox(width: icon != null ? 4 : 0),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ],
      ),
    );
  }
}
