import 'dart:convert';

import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final categoryRepositoryProvider =
    Provider<CategoryReposity>((_) => CategoryReposity());

class CategoryReposity {
  static final categoryEndpoint = "${dotenv.get('API_BASE_URL')}/categories";

  Future<List<Category>> fetchCategory() async {
    final url = Uri.parse(categoryEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Category.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
