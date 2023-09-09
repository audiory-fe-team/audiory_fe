import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWithLink extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? link;

  const HeaderWithLink({this.icon = null, required this.title, this.link});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon ?? Container(),
              const SizedBox(width: 6),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          Builder(builder: (context) {
            if (link == null) return SizedBox();
            return InkWell(
                onTap: () {
                  GoRouter.of(context).push(link ?? '');
                },
                child: Container(
                    width: 50,
                    height: 20,
                    child: Center(
                        child: Text('Thêm',
                            style: TextStyle(
                              color: appColors.primaryBase,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            )))));
          })
        ],
      ),
    );
  }
}
