import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class CategoryBadge extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoryBadge({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Stack(children: [
      Container(
          width: double.infinity,
          // height: 47,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(imgUrl, fit: BoxFit.cover),
          )),
      Positioned(
        bottom: 1,
        left: 6,
        child: Container(
          width: 86,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      )
    ]);
  }
}
