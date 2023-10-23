import 'package:audiory_v0/models/AuthUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  AuthUser _userDetails = AuthUser(
      id: '',
      fullName: '',
      username: '',
      avatarUrl: '',
      backgroundUrl: '',
      facebookUrl: '',
      numOfFollowers: 0,
      numOfFollowing: 0,
      createdDate: '',
      email: '',
      isEnabled: true,
      isOnline: true,
      updatedDate: '');
  AuthUser get userDetails => _userDetails;

  void setUserDetails(AuthUser userDetail) {
    _userDetails = userDetail;
    notifyListeners();
  }
}
