import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  AuthUser _userDetails = AuthUser(
    id: '',
    username: '',
    profilePhoto: '',
    role: '',
    email: '',
  );
  AuthUser get userDetails => _userDetails;

  void setUserDetails(AuthUser userDetail) {
    _userDetails = userDetail;
    notifyListeners();
  }
}
