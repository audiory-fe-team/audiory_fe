import 'dart:convert';

import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReadingListRepository {
  static final readingListEndpoint = "${dotenv.get('API_BASE_URL')}";

  static Future<List<ReadingList>> fetchMyReadingList() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$readingListEndpoint/users/me/reading-lists');

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
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => ReadingList.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load reading list');
    }
  }

  static Future<List<Story>> fetchReadingListStoriesById(String id) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$readingListEndpoint/reading-lists/$id/stories');

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
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load reading list story');
    }
  }
}
