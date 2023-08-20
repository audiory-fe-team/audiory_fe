import 'dart:convert';

import 'package:audiory_v0/models/Author.dart';
import 'package:http/http.dart' as http;

class AuthorService {
  static const baseURL = "http://34.29.203.235:3500/api";
  static final authorEndpoint = baseURL + "/users";

  Future<List<Author>> fetchAllAuthors({String keyword = ''}) async {
    final url = Uri.parse(authorEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['data'];

      return result.map((i) => Author.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }

  Future<Author?> fetchAuthorById(String? authorId) async {
    if (authorId == null || authorId == '') {
      return null;
    }
    final url = Uri.parse(authorEndpoint + "/$authorId");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final Author author =
            Author.fromJson(json.decode(responseBody)['data']);
        return author;
      } catch (error) {
        print(error);
        throw Exception(error.toString());
      }
    } else {
      throw Exception('Failed to author');
    }
  }
}
