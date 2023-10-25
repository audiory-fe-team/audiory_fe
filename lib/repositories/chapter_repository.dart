import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final chapterRepositoryProvider =
    Provider<ChapterRepository>((_) => ChapterRepository());

class ChapterRepository {
  static final chapterEndpoint = "${dotenv.get('API_BASE_URL')}/chapters";
  static final chapterVersionEndpoint =
      "${dotenv.get('API_BASE_URL')}/chapter-version";

  final dio = Dio();

  Future<bool> createChapter(body, formFile) async {
    final url = Uri.parse(chapterEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    final request = await http.MultipartRequest('POST', url)
      ..fields.addAll(body);
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

  Future<void> buyChapter(storyId, chapterId, body) async {
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final userId = JwtDecoder.decode(jwtToken as String)['user_id'];
    final url = Uri.parse(
        '${Endpoints().user}/$userId/stories/$storyId/chapters/$chapterId/access');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }

    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to buy chapter');
    }
  }

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
      try {
        final Chapter chapter =
            Chapter.fromJson(json.decode(responseBody)['data']);
        return chapter;
      } catch (error) {
        print("egagag");
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch chapter');
    }
  }

  Future<Chapter?> fetchChapterById(String? chapterId) async {
    if (chapterId == null) {
      throw Exception('Failed to fetch chapter');
    }
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    try {
      final response = await dio.get("$chapterEndpoint/$chapterId",
          options: Options(headers: header));

      final Chapter chapter = Chapter.fromJson(response.data['data']);
      return chapter;
    } on DioException catch (e) {
      print(e.response);
    }
    return null;
  }

  static Future<List<Comment>> fetchCommentsByChapterId(
      {required String chapterId,
      int offset = 1,
      int limit = 10,
      String sortBy = 'like_count'}) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$chapterEndpoint/$chapterId/comments').replace(
        queryParameters: {
          'offset': '$offset',
          'limit': '$limit',
          'sort_by': sortBy
        });

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
        return result.map((i) => Comment.fromJson(i)).toList();
      } catch (error) {
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch comments');
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
