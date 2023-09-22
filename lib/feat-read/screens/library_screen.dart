import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? authUser = AuthRepository().currentUser;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
        child: Text(
      authUser?.uid ?? '',
      style: textTheme.titleLarge,
    ));
  }
}
