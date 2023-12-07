import 'dart:convert';
import 'dart:io';
import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/wall-comment/wall_comment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../models/AuthUser.dart';

class ProfileRepository {
  static final profileEndpoint = "${dotenv.get('API_BASE_URL')}/users";
  final dio = Dio();

  Future<List<Profile>> fetchAllProfiles({String? keyword = ''}) async {
    final url = Uri.parse(profileEndpoint)
        .replace(queryParameters: {'keyword': keyword});
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];

      return result.map((i) => Profile.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<Profile?> fetchProfileByUserId() async {
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];
    print(userId);
    final url = Uri.parse("$profileEndpoint/$userId/profile");
    Map<String, String> header = {
      "Content-type": "application/json,charset=UTF-8",
      "Accept": "application/json",
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final Profile profile =
            Profile.fromJson(json.decode(responseBody)['data']);
        return profile;
      } on DioException catch (error) {
        throw Exception(error.toString());
      }
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<Profile?> updateProfile(formFile, Map<String, String> reqBody) async {
    //get userId
    String? value = await const FlutterSecureStorage().read(key: 'currentUser');
    AuthUser? currentUser =
        value != null ? AuthUser.fromJson(jsonDecode(value)['data']) : null;
    String? userId = currentUser?.id;
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    //call api
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }

    //sending form data
    final Map<String, String> firstMap = reqBody;
    final Map<String, MultipartFile> secondeMap;
    //if the img does not change, do not have form_file field
    if (formFile[0] != null || formFile[0].runtimeType != String) {
      secondeMap = {};
    } else {
      File file = File(formFile[0].path); //import dart:io
      secondeMap = {'form_file': await MultipartFile.fromFile(file.path)};
    }

    //merge 2 map
    final Map<String, dynamic> finalMap = {};
    finalMap.addAll(firstMap);
    finalMap.addAll(secondeMap);

    final FormData formData = FormData.fromMap(finalMap);

    try {
      final response = await dio.patch('${Endpoints().user}/$userId/profile',
          data: formData, options: Options(headers: header));
      if (kDebugMode) {
        print('res for update');
        print(response);
      }

      final result = response.data['data']; //do not have to json decode
      return Profile.fromJson(result);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('err');
        print(e.response);
      }
      return null;
    }
  }

  Future<Profile?> updateNewUserProfile(
      formFile, Map<String, String> reqBody, String userId) async {
    //call api
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }

    //sending form data
    final Map<String, String> firstMap = reqBody;
    final Map<String, MultipartFile> secondeMap;
    //if the img does not change, do not have form_file field
    if (formFile == null) {
      secondeMap = {};
    } else {
      File file = File(formFile[0].path); //import dart:io
      secondeMap = {'form_file': await MultipartFile.fromFile(file.path)};
    }

    //merge 2 map
    final Map<String, dynamic> finalMap = {};
    finalMap.addAll(firstMap);
    finalMap.addAll(secondeMap);
    print(finalMap);
    final FormData formData = FormData.fromMap(finalMap);

    try {
      final response = await dio.patch('${Endpoints().user}/$userId/profile',
          data: formData, options: Options(headers: header));
      if (kDebugMode) {
        print('res for update');
        print(response);
      }

      final result = response.data['data']; //do not have to json decode
      return Profile.fromJson(result);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('err');
        print(e.response);
      }
      return null;
    }
  }

  Future<List<WallComment>?> fetchAllWallComment({String? userId = ''}) async {
    final url = Uri.parse('$profileEndpoint/$userId/wall');

    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];

      return result.map((i) => WallComment.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }
}
