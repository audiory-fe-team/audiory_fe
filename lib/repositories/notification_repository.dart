import 'dart:convert';

import 'package:audiory_v0/models/notification/noti_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class NotificationRepostitory {
  static final notificationsEndpoint =
      "${dotenv.get('API_BASE_URL')}/notifications";
  final dio = Dio();

  static Future<List<Noti>> fetchNoties({
    int offset = 0,
    int limit = 10,
  }) async {
    final url = Uri.parse(notificationsEndpoint).replace(queryParameters: {
      'offset': '$offset',
      'limit': '$limit',
    });

    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => Noti.fromJson(i)).toList();
      } catch (error) {
        rethrow;
      }
    } else {
      throw jsonDecode(responseBody)['message'];
    }
  }
}
