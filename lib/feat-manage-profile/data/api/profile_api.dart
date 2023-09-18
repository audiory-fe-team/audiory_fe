import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/network/constant/endpoints.dart';
import '../../../core/network/dio_client.dart';

class ProfileApi {
  final DioClient _dioClient;

  ProfileApi(this._dioClient);

  Future<Map<String, dynamic>> fetchUserProfileById(String userId) async {
    try {
      const storage = FlutterSecureStorage();
      String? value = await storage.read(key: 'jwt');

      var headers = <String, String>{
        // 'Authorization': 'Bearer $value',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final res = await _dioClient.get('${Endpoints().user}/$userId/profile',
          options: Options(headers: headers));
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
