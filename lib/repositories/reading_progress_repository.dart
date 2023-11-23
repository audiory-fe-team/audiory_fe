import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ReadingProgressRepository {
  static final readingProgressEndpoint =
      "${dotenv.get('API_BASE_URL')}/reading-progress";

  static Future<dynamic> updateProgress(
      {required String storyId,
      required String chapterId,
      // required String paragraphId,
      required int readingPosition}) async {
    final url = Uri.parse('$readingProgressEndpoint/$storyId');
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

    final response = await http.put(url,
        body: jsonEncode({
          'chapter_id': chapterId,
          'is_completed': false,
          'reading_position': readingPosition,
        }),
        headers: headers);

    if (response.statusCode == 200) {
      return HttpStatus.accepted;
    } else {
      throw Exception('Failed to update reading progress');
    }
  }
}
