import 'dart:convert';

import 'package:audiory_v0/models/Chapter.dart';
import 'package:http/http.dart' as http;

class ChapterServices {
  static const baseURL = "http://34.101.77.146:3500/api";
  static final chapterUrl = baseURL + "/chapters";

  Future<Chapter> fetchChapterDetail(String? chapterId) async {
    if (chapterId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse(chapterUrl + "/$chapterId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final Chapter chapter =
          Chapter.fromJson(json.decode(response.body)['data']);
      return chapter;
    } else {
      throw Exception('Failed to chapter');
    }
  }
}
