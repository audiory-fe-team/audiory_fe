import 'package:flutter/material.dart';

class LibraryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 172, 136, 28),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Thư viện',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ])));
  }
}
