import 'dart:convert';

import 'package:audiory_v0/models/Category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static const baseURL = "http://34.29.203.235:3500/api";
  static final categoryEndpoint = baseURL + "/categories";

  Future<List<Category>> fetchAllCategories() async {
    final url = Uri.parse(categoryEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['data'];

      return result.map((i) => Category.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
