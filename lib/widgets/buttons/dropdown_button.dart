import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  final List? list;
  const AppDropdownButton({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.white)),
        child: DropdownButton(
          onChanged: null,
          dropdownColor: Colors.white,
          style: TextStyle(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
          value: 'ar',
          items: [
            DropdownMenuItem(child: Text('English'), value: 'en'),
            DropdownMenuItem(child: Text('العربية'), value: 'ar'),
          ],
        ));
  }
}
