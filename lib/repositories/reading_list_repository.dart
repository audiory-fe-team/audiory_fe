import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReadingListRepository {
  static final readingListEndpoint = dotenv.get('API_BASE_URL');

  static Future<List<ReadingList>> fetchMyReadingList() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    final url = Uri.parse('$readingListEndpoint/users/me/reading-lists')
        .replace(queryParameters: {'page': '1', 'page_size': '20'});

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
    final url = Uri.parse('$readingListEndpoint/reading-lists/$id/stories')
        .replace(queryParameters: {'page': '1', 'page_size': '40'});

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

  static Future<void> addStoryToReadingList(readingListId, storyId) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    final url = Uri.parse(
        '$readingListEndpoint/reading-lists/$readingListId/stories/$storyId');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    // if (jwtToken != null) {
    //   headers['Authorization'] = 'Bearer $jwtToken';
    // }

    final response = await http.post(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load reading list');
    }
  }

  static Future<ReadingList> addReadingList(body, formFile) async {
    final dio = Dio();

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    final Map<String, String> firstMap = body;
    final Map<String, MultipartFile> secondeMap;

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

    final response = await dio.post('$readingListEndpoint/reading-lists',
        data: formData, options: Options(headers: headers));
    final result = response.data; //do not have to json decode
    // final request = http.MultipartRequest('POST', url)
    //   ..fields.addAll(body)
    //   ..files.add(await http.MultipartFile.fromPath(
    //     'form_file',
    //     file.path,
    //   ));
    // request.headers.addAll(headers);

    // final response = await request.send();
    // final respStr = await response.stream.bytesToString();

    if (result['code'] == 200) {
      return ReadingList.fromJson(result['data']);
    } else {
      throw Exception('Failed to edit reading list');
    }
  }

  static Future<ReadingList> editReadingList(
      readingListId, body, formFile) async {
    final dio = Dio();
    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    //sending form data
    final Map<String, String> firstMap = body;
    final Map<String, MultipartFile> secondeMap;
    //if the img does not change, do not have form_file field
    if (formFile.isEmpty) {
      secondeMap = {};
    } else if (formFile[0].runtimeType == String) {
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
      final response = await dio.put(
          '$readingListEndpoint/reading-lists/$readingListId',
          data: formData,
          options: Options(headers: headers));
      final result = response.data; //do not have to json decode
      print('res for update');
      print(response.data);
      if (result['code'] == 200) {
        return ReadingList.fromJson(result['data']);
      } else {
        throw Exception('Failed to edit reading list');
      }
    } catch (e) {
      throw Exception('Failed to edit reading list');
    }
  }

  static Future<void> deleteReadingList(String id) async {
    final url = Uri.parse('$readingListEndpoint/reading-lists/$id');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.delete(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load reading list story');
    }
  }

  static Future<void> deleteStoryFromReadingList(
      String id, String storyId) async {
    final url =
        Uri.parse('$readingListEndpoint/reading-lists/$id/stories/$storyId');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.delete(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load reading list story');
    }
  }
}
