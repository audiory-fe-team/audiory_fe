import 'dart:convert';

import 'package:audiory_v0/models/Chapter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChapterServices {
  static final chapterEndpoint = "${dotenv.get('API_BASE_URL')}/chapters";

  Future<Chapter> fetchChapterDetail(String? chapterId) async {
    if (chapterId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse(chapterEndpoint + "/$chapterId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final Chapter chapter =
          Chapter.fromJson(json.decode(responseBody)['data']);
      return chapter;
    } else {
      throw Exception('Failed to chapter');
    }
  }
}
