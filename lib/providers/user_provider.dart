import 'package:audiory_v0/models/AuthUser.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List<AuthUser>? user;
  bool loading = false;
}
