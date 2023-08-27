import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/models/Chapter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChapterServices {
  static final chapterEndpoint = "${dotenv.get('API_BASE_URL')}/chapters";
  static final chapterVersionEndpoint =
      "${dotenv.get('API_BASE_URL')}/chapter-version";

  Future<Chapter> fetchChapterDetail(String? chapterId) async {
    if (chapterId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse("$chapterEndpoint/$chapterId");
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

  Future<bool> createChapterVersion(body, formFile) async {
    File file = File(formFile[0].path); //import dart:io
    final url = Uri.parse(chapterVersionEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    final request = await http.MultipartRequest('POST', url)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath(
        'form_file',
        file.path,
      ));
    request.headers.addAll(header);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    var encoded = json.decode(respStr);
    print('res');
    print(respStr);
    print(encoded['code']);
    print(encoded['data']);

    if (response.statusCode == 200) {
      return true;
      // final List<dynamic> result = jsonDecode(response.body)['data'];
      // return result.map((i) => Story.fromJson(i)).toList();
    } else {
      return false;
      throw Exception('Failed to create chapter version');
    }
  }
}
