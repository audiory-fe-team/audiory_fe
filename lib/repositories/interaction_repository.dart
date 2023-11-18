import 'dart:convert';
import 'dart:io';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/category/app_category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class InteractionRepository {
  static final followEndpoint = "${dotenv.get('API_BASE_URL')}/follows";
  static final reportEndpoint = "${dotenv.get('API_BASE_URL')}/reports";
  static final privacyEndpoint = "${dotenv.get('API_BASE_URL')}/privacy";

  Future<dynamic> follow(String userId) async {
    final url = Uri.parse('$followEndpoint/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.post(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('FOLOOW $responseBody');
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<dynamic> unfollow(String userId) async {
    final url = Uri.parse('$followEndpoint/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.delete(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('UNFOLLOW $responseBody');
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<dynamic> block(String userId) async {
    final url = Uri.parse('$privacyEndpoint/block/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.put(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('BLOCK $responseBody');
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<dynamic> unblock(String userId) async {
    final url = Uri.parse('$privacyEndpoint/unblock/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.put(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('BLOCK $responseBody');
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<List<Profile?>> getBlockAccount() async {
    final url = Uri.parse('$privacyEndpoint/blocked-accounts');
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List result = jsonDecode(responseBody)['data'];
      print(result);
      return result.map((e) => Profile.fromJson(e)).toList();
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<dynamic> mute(String userId) async {
    final url = Uri.parse('$privacyEndpoint/mute/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.put(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('BLOCK $responseBody');
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<dynamic> unmute(String userId) async {
    final url = Uri.parse('$privacyEndpoint/unmute/$userId');
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.put(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<List<Profile?>> getMutedAccounts() async {
    final url = Uri.parse('$privacyEndpoint/muted-accounts');
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List result = jsonDecode(responseBody)['data'];
      print(result);
      return result.map((e) => Profile.fromJson(e)).toList();
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }

  Future<dynamic> report(body, formFile) async {
    print(body);
    print(formFile);
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    final dio = Dio();
    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      headers['Authorization'] = 'Bearer $jwt';
    }

    //sending form data
    final Map<String, String> firstMap = body;
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

    final FormData formData = FormData.fromMap(finalMap);

    try {
      final response = await dio.post(reportEndpoint,
          data: formData, options: Options(headers: headers));
      print(response);
      final result = response.data; //do not have to json decode
      print('res for update');
      print(response.data);
      if (result['code'] == 200) {
        return true;
      } else {
        throw Exception('Failed to report');
      }
    } catch (e) {
      throw Exception('Failed to report');
    }
  }
}
