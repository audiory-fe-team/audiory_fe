import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/Chapter.dart';
import '../models/Story.dart';

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static const baseURL = "http://34.71.125.94:3500/api";
  static const storiesEndpoint = "$baseURL/stories";
  final dio = Dio();
  Future<List<Story>> fetchStories() async {
    final url = Uri.parse(storiesEndpoint);
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<Story?> fetchStoriesById(String? storyId) async {
    print('storyId  $storyId');
    if (storyId == null) {
      return null;
    }

    final url = Uri.parse('$storiesEndpoint/$storyId');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (kDebugMode) {
      print('res story');
      print(jsonDecode(responseBody)['data']);
    }

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Story.fromJson(jsonDecode(responseBody)['data']);
    } else {
      return null;
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Chapter>?> fetchAllChaptersStoryById(String? storyId) async {
    if (storyId == null) {
      return null;
    }

    final url = Uri.parse('$storiesEndpoint/$storyId/chapters');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']; //have to add List<dynamic> type
      return result.map((i) => Chapter.fromJson(i)).toList();
    } else {
      return null;
    }
  }

  Future<List<Story>> fetchStoriesByUserId(String userId) async {
    final url;
    if (userId != '') {
      url = Uri.parse('$baseURL/users/$userId/stories');
    } else {
      url = Uri.parse('$baseURL/stories');
    }
    print('userId: $userId');

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<Story?> createStory(body, formFile) async {
    File file = File(formFile[0].path); //import dart:io
    final url = Uri.parse(storiesEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    final request = http.MultipartRequest('POST', url)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath(
        'form_file',
        file.path,
      ));
    request.headers.addAll(header);
    var response = await request.send();

    final respStr = await response.stream.bytesToString();

    var encoded = jsonDecode(respStr);

    if (kDebugMode) {
      print('res');
      print(
        jsonDecode(respStr),
      );
    }

    if (encoded['code'] == 200) {
      final result = encoded['data'];
      print(encoded['data']['tags'].runtimeType);
      print(encoded['data']['chapters'].runtimeType);
      // final chapterList = jsonDecode(encoded['data']['chapters'])
      //     .map((chapterJson) => Chapter.fromJson(chapterJson))
      //     .toList();
      // print(chapterList);
      print(encoded['data']);
      //error when jsonDecode story
      return Story.fromJson(result);
    } else {
      return null;
      throw Exception('Failed to load stories');
    }
  }

  //using dio package for calling PATCH request
  Future<Story?> editStory(String? storyId, body, formFile) async {
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    //sending form data
    final Map<String, String> firstMap = body;
    final Map<String, MultipartFile> secondeMap;
    //if the img does not change, do not have form_file field
    print(formFile[0] is String);
    if (formFile[0] is String) {
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
    //create global interceptors
    // print(formData);
    try {
      final response = await dio.patch('$storiesEndpoint/$storyId',
          data: formData, options: Options(headers: header));
      print('res');
      print(response);

      final result = response.data['data']; //do not have to json decode
      return Story.fromJson(result);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('err');
        print(e.response);
      }
      return null;
    }

    // if (kDebugMode) {
    //   print('res');
    //   print(response);
    //   print(response.headers);
    //   print(response.requestOptions);
    //   print(response.statusCode);
    // }
  }

  Future<int> deleteStoryById(String storyId) async {
    print(storyId);
    final url = Uri.parse('$baseURL/stories/$storyId');
    final response = await http.delete(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print('body $responseBody');
    }
    if (response.statusCode == 200) {
      final int result = jsonDecode(responseBody)['code'];
      return result;
    } else {
      return 0;
      throw Exception('Failed to load stories');
    }
  }

  Future<int> unPublishStoryById(String storyId) async {
    print(storyId);
    final url = Uri.parse('$baseURL/stories/$storyId');
    final response = await http.delete(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print('body $responseBody');
    }
    if (response.statusCode == 200) {
      final int result = jsonDecode(responseBody)['code'];
      return result;
    } else {
      return 0;
      throw Exception('Failed to load stories');
    }
  }
}
