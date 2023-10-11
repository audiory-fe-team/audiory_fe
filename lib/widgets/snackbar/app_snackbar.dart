import 'package:flutter/material.dart';
import '../../models/enums/SnackbarType.dart';

class AppSnackBar {
  AppSnackBar._();
  static buildSnackbar(BuildContext context, String message, String? action,
      SnackBarType? type) {
    final size = MediaQuery.of(context).size;

    final typeOfSnackbar = type ?? SnackBarType.success;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,

      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      dismissDirection: DismissDirection.down,

      backgroundColor: typeOfSnackbar.displayBgColor,
      duration: Duration(seconds: 3),
      content: Row(
        children: [
          Flexible(
              child: Icon(
            typeOfSnackbar.displayIcon,
            color: typeOfSnackbar.displayTextColor,
          )),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: typeOfSnackbar.displayTextColor),
            ),
          ),
        ],
      ),

      // action: SnackBarAction(
      //   textColor: typeOfSnackbar.displayTextColor,
      //   label: action ?? 'Ẩn',
      //   onPressed: () {},
      // ),
    ));
  }

  static buildTopSnackBar(BuildContext context, String message, String? action,
      SnackBarType? type) {
    final size = MediaQuery.of(context).size;

    final typeOfSnackbar = type ?? SnackBarType.success;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.only(left: 8, right: 8, bottom: size.height - 200),
      dismissDirection: DismissDirection.up,

      backgroundColor: typeOfSnackbar.displayBgColor,
      duration: const Duration(seconds: 3),
      content: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                child: Icon(
              typeOfSnackbar.displayIcon,
              color: typeOfSnackbar.displayTextColor,
            )),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: typeOfSnackbar.displayTextColor),
              ),
            ),
          ],
        ),
      ),

      // action: SnackBarAction(
      //   textColor: typeOfSnackbar.displayTextColor,
      //   label: action ?? 'Ẩn',
      //   onPressed: () {},
      // ),
    ));
  }
}
