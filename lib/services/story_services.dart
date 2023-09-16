import 'dart:convert';

import 'package:audiory_v0/models/Story.dart';
import 'package:http/http.dart' as http;

class StoryService {
  static const baseURL = "http://34.71.125.94:3500/api";
  static const storiesEndpoint = baseURL + "/stories";

  Future<List<Story>> fetchStories({String keyword = ''}) async {
    final url = Uri.parse(storiesEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];

      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<Story> fetchStoryById(String? storyId) async {
    if (storyId == null) {
      throw Exception('Failed to fetch story');
    }

    final url = Uri.parse(storiesEndpoint + "/$storyId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final Story story = Story.fromJson(json.decode(responseBody)['data']);
      return story;
    } else {
      throw Exception('Failed to chapter');
    }
  }
}
