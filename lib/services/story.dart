import 'dart:convert';

import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoryService {
  static final baseURL = "http://34.101.77.146:3500/api";
  static final storiesEndpoint = baseURL + "/stories";

  Future<List<StoryServer>> fetchStories() async {
    final url = Uri.parse(storiesEndpoint);
    final response = await http.get(url);
    print('res');
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      final List result = jsonDecode(response.body).data;
      return result.map((i) => StoryServer.fromJson(jsonDecode(i))).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
