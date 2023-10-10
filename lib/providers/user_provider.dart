import 'package:audiory_v0/models/AuthUser.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List<UserServer>? user;
  bool loading = false;
}
