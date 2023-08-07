import 'dart:convert';

import 'package:audiory_v0/feat-explore/models/filter.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:http/http.dart' as http;

class StoryService {
  static const baseURL = "http://34.101.77.146:3500/api";
  static final storiesEndpoint = baseURL + "/stories";

  Future<List<StoryServer>> fetchStories(String? keyword) async {
    final url = Uri.parse(storiesEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['data'];
      return result.map((i) => StoryServer.fromJson(i)).toList();
    } else {
      print("========error=====");
      throw Exception('Failed to load stories');
    }
  }
}
