import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/models/Story.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/Chapter.dart';

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static final baseURL = "http://34.29.203.235:3500/api";
  static final storiesEndpoint = baseURL + "/stories";

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
    if (storyId == null) {
      return null;
    }

    final url = Uri.parse('$storiesEndpoint/$storyId');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (kDebugMode) {
      print('res');
      print(jsonDecode(responseBody)['data']);
    }

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Story.fromJson(result as Map<String, dynamic>);
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
    final url = Uri.parse(
        '$baseURL/users/72d9245a-399d-11ee-8181-0242ac120002/stories');
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
