import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../core/network/dio_client.dart';
import '../core/network/dio_exceptions.dart';

class UserProvider extends ChangeNotifier {
  List<UserServer>? user;
  bool loading = false;
}
