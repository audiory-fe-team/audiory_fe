import 'package:audiory_v0/feat-manage-profile/data/api/profile_api.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/dio_exceptions.dart';

class ProfileRepository {
  final ProfileApi _profileApi;

  ProfileRepository(this._profileApi);

  Future<Profile?> fecthProfileByUserId(String userId) async {
    try {
      final res = await _profileApi.fetchUserProfileById(userId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST profileApi : ${res.toString()}');
      }
      final profileData = Profile.fromJson(res['data']);
      return profileData;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }
      rethrow;
    }
  }
}
