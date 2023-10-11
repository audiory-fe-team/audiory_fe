import 'dart:convert';

import 'package:audiory_v0/models/Library.dart';
import 'package:audiory_v0/models/story/story_model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LibraryRepository {
  static final libraryEndpoint = "${dotenv.get('API_BASE_URL')}/libraries";

  static Future<Library> fetchMyLibrary() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$libraryEndpoint/me');

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
      final result = jsonDecode(responseBody)['data'];
      return Library.fromJson(result);
    } else {
      throw Exception('Failed to load library');
    }
  }

  static Future<void> addStoryMyLibrary(String storyId) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$libraryEndpoint/me/stories/$storyId');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load library');
    }
  }

  static Future<void> deleteStoryFromMyLibrary(String storyId) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$libraryEndpoint/me/stories/$storyId');

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
    } else {
      throw Exception('Failed to delete story');
    }
  }

  static Future<Story> downloadStory(String storyId) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse('$libraryEndpoint/me/stories/$storyId');

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
      final result = jsonDecode(responseBody)['data'];
      return Story.fromJson(result);
    } else {
      throw Exception('Failed to download story');
    }
  }
}
