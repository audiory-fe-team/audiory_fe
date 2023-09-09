import 'dart:convert';

import 'package:audiory_v0/models/Story.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static final storiesEndpoint = "${dotenv.get('API_BASE_URL')}/stories";

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

    if (response.statusCode == 200) {
      final Story result = jsonDecode(response.body)['data'];
      return Story.fromJson(result as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<void> createStory(body) async {
    final url = Uri.parse(storiesEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };
    final response = await http.post(headers: header, url, body: body);

    if (response.statusCode == 200) {
      // final List<dynamic> result = jsonDecode(response.body)['data'];
      // return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
