import 'package:flutter/material.dart';

class InteractionStoryInfo {
  final String key;
  final String value;
  final Icon icon;

// added '?'

  const InteractionStoryInfo(
      {required this.key, required this.value, required this.icon});
  // can also add 'required' keyword
}
