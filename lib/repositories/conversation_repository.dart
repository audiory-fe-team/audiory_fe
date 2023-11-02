import 'dart:convert';

import 'package:audiory_v0/models/conversation/conversation_model.dart';
import 'package:audiory_v0/models/message/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRepository {
  String conversationEndpoint = "${dotenv.get('API_BASE_URL')}/conversations";
  final dio = Dio();

  Future<List<Conversation>> fetchAllConversations({
    int offset = 1,
    int limit = 10,
  }) async {
    final url = Uri.parse(conversationEndpoint);
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      print('response ${response.body}');
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => Conversation.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load conversation');
    }
  }

  Future<Conversation?> fetchConversationById({
    String? conversationId,
    int offset = 1,
    int limit = 10,
  }) async {
    if (conversationId != null) {
      conversationEndpoint += '/$conversationId?offset=$offset&limit=$limit';
    }
    final url = Uri.parse('$conversationEndpoint');
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Conversation.fromJson(result);
    } else {
      throw Exception('Failed to load conversation');
    }
  }

  Future<List<Message>?> fetchMessagesByConversationId({
    String? conversationId,
    int offset = 1,
    int limit = 10,
  }) async {
    if (conversationId != null) {
      conversationEndpoint += '/$conversationId?offset=$offset&limit=$limit';
    }
    final url = Uri.parse('$conversationEndpoint');
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Conversation.fromJson(result).messages;
    } else {
      throw Exception('Failed to load conversation');
    }
  }
}
