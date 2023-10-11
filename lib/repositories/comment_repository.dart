import 'dart:convert';

import 'package:audiory_v0/models/Comment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  static final commentsEndpoint = "${dotenv.get('API_BASE_URL')}/comments";

  static Future<dynamic> createComment(
      {required String chapterId,
      required String paraId,
      String? parentId,
      required String text,
      String? userId}) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse(commentsEndpoint);

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.post(url,
        body: jsonEncode({
          'chapter_id': chapterId,
          'paragraph_id': paraId,
          'text': text,
          if (parentId != null) 'parent_id': parentId,
          if (userId != null) 'user_id': userId,
        }),
        headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create comment');
    }
  }

  static Future<dynamic> deleteComment({required String commentId}) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$commentsEndpoint/$commentId');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete comment');
    }
  }

  static Future<Comment> fetchCommentById({required String commentId}) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$commentsEndpoint/$commentId');

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
      return Comment.fromJson(jsonDecode(responseBody)['data']);
    } else {
      throw Exception('Failed to create comment');
    }
  }
}
