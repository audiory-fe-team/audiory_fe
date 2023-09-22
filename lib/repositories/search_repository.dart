import 'dart:convert';

import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class SearchRepository {
  static final searchEndpoint = "${dotenv.get('API_BASE_URL')}/search";

  static Future<List<SearchStory>> searchStory(
      {String keyword = '',
      String? category,
      String? tags,
      String? sortBy,
      String? isPaywalled,
      String? isMature,
      int offset = 1,
      int limit = 10}) async {
    final url = Uri.parse("$searchEndpoint/stories").replace(queryParameters: {
      'keyword': keyword,
      'offset': '$offset',
      'limit': '$limit',
      if (tags != null) 'tags': '$tags',
      if (category != null) 'category': '$category',
      if (sortBy != null) 'sort_by': '$sortBy',
      if (isPaywalled != null) 'is_paywalled': '$isPaywalled',
      if (isMature != null) 'is_mature': '$isMature',
    });

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']['hits']['hits'];

      return result.map((i) => SearchStory.fromJson(i['_source'])).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<List<SearchStory>> searchCategoryStories(
      {String? category,
      String? sortBy,
      String? isMature,
      int offset = 1,
      int limit = 10}) async {
    final url = Uri.parse("$searchEndpoint/categories/$category")
        .replace(queryParameters: {
      'offset': '$offset',
      'limit': '$limit',
      if (sortBy != null) 'sort_by': '$sortBy',
      if (isMature != null) 'is_mature': '$isMature',
    });

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']['hits']['hits'];

      return result.map((i) => SearchStory.fromJson(i['_source'])).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<List<SearchStory>> searchTagStories(
      {required String tagId,
      String? sortBy,
      String? isMature,
      int offset = 1,
      int limit = 10}) async {
    final url =
        Uri.parse("$searchEndpoint/tags/$tagId").replace(queryParameters: {
      'offset': '$offset',
      'limit': '$limit',
      if (sortBy != null) 'sort_by': '$sortBy',
      if (isMature != null) 'is_mature': '$isMature',
    });

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']['hits']['hits'];

      return result.map((i) => SearchStory.fromJson(i['_source'])).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<List<Profile>> searchUser(
      {String keyword = '', int offset = 1, int limit = 1}) async {
    final url = Uri.parse("$searchEndpoint/users").replace(
      queryParameters: {
        'keyword': keyword,
        'offset': '$offset',
        'limit': '$limit'
      },
    );

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']['hits']['hits'];

      return result.map((i) => Profile.fromJson(i['_source'])).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
