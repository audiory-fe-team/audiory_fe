import 'dart:convert';

import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static final baseURL = "http://34.29.203.235:3500/api";
  static final storiesEndpoint = baseURL + "/stories";

  Future<List<StoryServer>> fetchStories() async {
    final url = Uri.parse(storiesEndpoint);
    final response = await http.get(url);
    print('res');
    // print(response.body);
    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body)['data'];
      return result.map((i) => StoryServer.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<StoryServer> fetchStoriesById(String storyId) async {
    final url = Uri.parse(storiesEndpoint + '/${storyId}');
    final response = await http.get(url);
    print('res');
    print(response.body);
    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      final StoryServer result = jsonDecode(response.body)['data'];
      return StoryServer.fromJson(result as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<void> createStory(body) async {
    print('ako');
    final url = Uri.parse(storiesEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };
    // final response = await http.post(headers: header, url, body: body);
    final request = await http.MultipartRequest('POST', url)
      ..fields.addAll(body);
    request.headers.addAll(header);
    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    print('res');
    print(
      jsonDecode(respStr),
    );
    print("This is the Status Code$respStr");
    var encoded = json.decode(respStr);

    print(encoded['status']);

    // print('res');
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      // final List<dynamic> result = jsonDecode(response.body)['data'];
      // return result.map((i) => StoryServer.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
