import 'dart:convert';

import 'package:audiory_v0/models/SearchStory.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class SearchRepository {
  static final searchEndpoint = "${dotenv.get('API_BASE_URL')}/search";

  Future<List<SearchStory>> searchStory({String? keyword = ''}) async {
    final url = Uri.parse("$searchEndpoint/stories")
        .replace(queryParameters: {'keyword': keyword ?? ''});

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
}
