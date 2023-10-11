import 'dart:convert';

import 'package:audiory_v0/models/Comment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ParaRepository {
  static final paraEndpoint = "${dotenv.get('API_BASE_URL')}/paragraphs";

  static Future<List<Comment>> fetchCommentsByParaId(
      {required String paraId,
      int offset = 1,
      int limit = 10,
      String sortBy = 'like_count'}) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$paraEndpoint/$paraId/comments').replace(
        queryParameters: {
          'offset': '$offset',
          'limit': '$limit',
          'sort_by': sortBy
        });

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => Comment.fromJson(i)).toList();
      } catch (error) {
        throw (error);
      }
    } else {
      throw Exception('Failed to fetch comments');
    }
  }
}
