import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChapterVersionRepository {
  static final chapterEndpoint = "${dotenv.get('API_BASE_URL')}/chapters";
  static final chapterVersionEndpoint =
      "${dotenv.get('API_BASE_URL')}/chapter-version";

  Future<List<ChapterVersion>?> fetchChapterVersionsOfChapter(
      String? chapterId) async {
    if (chapterId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse("$chapterEndpoint/$chapterId/chapter-version");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');

    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => ChapterVersion.fromJson(i)).toList();
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch chapter');
    }
  }

  Future<ChapterVersion?> fetchChapterVersionByChapterVersionId(
      String? chapterVersionId) async {
    if (chapterVersionId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse("$chapterVersionEndpoint/$chapterVersionId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');

    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        return ChapterVersion.fromJson(result);
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch chapter');
    }
  }

  Future<dynamic?> revertChapterVersion(String? chapterVersionId) async {
    if (chapterVersionId == null) {
      throw Exception('Failed to fetch chapter');
    }

    final url = Uri.parse("$chapterVersionEndpoint/revert/$chapterVersionId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');

    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }

    final response = await http.post(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        print(result);
        return ChapterVersion.fromJson(result);
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch chapter');
    }
  }
}
