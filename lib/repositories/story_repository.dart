import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static final storiesEndpoint = "${dotenv.get('API_BASE_URL')}/stories";
  final dio = Dio();

  Future<List<Story>> fetchStories({String? keyword = ''}) async {
    final url = Uri.parse(storiesEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<Story> fetchStoryById(String storyId) async {
    final url = Uri.parse('$storiesEndpoint/$storyId');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Story.fromJson(result);
    } else {
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

    if (kDebugMode) {
      print('res');
      print(response.body);
      print(jsonDecode(response.body)['data']);
    }

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result.map((i) => Chapter.fromJson(i)).toList();
    } else {
      return null;
    }
  }

  Future<List<Story>> fetchStoriesByUserId(String userId) async {
    final url = Uri.parse('${Endpoints().user}/${userId}/stories');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Story>?> fetchPublishedStoriesByUserId(String userId) async {
    final url = Uri.parse('${Endpoints().user}/$userId/stories/published');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print('RES FOR PUBLISHED  ${response.body}');
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<ReadingList>?> fetchReadingStoriesByUserId(String userId) async {
    final url = Uri.parse('${Endpoints().user}/$userId/reading-lists');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print('RES FOR READING  ${response.body}');
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      print(result);
      print(result.map((i) => ReadingList.fromJson(i)).toList());
      return result.map((i) => ReadingList.fromJson(i)).toList();
    } else {
      return null;
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Story>?> fetchTopStoriesForNewUser() async {
    final url = Uri.parse('${Endpoints().story}/sample/3');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print('RES FOR TOP STORIES  ${response.body}');
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
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
      print(encoded['data']['chapters']);
    }

    if (encoded['code'] == 200) {
      final result = encoded['data'];
      return Story.fromJson(result);
    } else {
      return null;
      throw Exception('Failed to load stories');
    }
  }
}
