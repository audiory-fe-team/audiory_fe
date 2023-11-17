import 'dart:convert';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/category/app_category_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class InteractionRepository {
  static final followEndpoint = "${dotenv.get('API_BASE_URL')}/follows";
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

  Future<List<Profile?>> getMutedAccounts() async {
    final url = Uri.parse('$privacyEndpoint/muted-accounts');
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);
    if (response.statusCode == 200) {
      final dynamic result = jsonDecode(responseBody)['data'];
      return result.map((e) => Profile.fromJson(result));
    } else {
      final result = jsonDecode(responseBody)['message'];
      return result;
    }
  }
}
