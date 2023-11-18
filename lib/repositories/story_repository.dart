import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

final storyRepositoryProvider =
    Provider<StoryRepostitory>((_) => StoryRepostitory());

class StoryRepostitory {
  static final storiesEndpoint = "${dotenv.get('API_BASE_URL')}/stories";
  final dio = Dio();

  Future<List<Story>> fetchStories({String? keyword = ''}) async {
    final url = Uri.parse(storiesEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => Story.fromJson(i)).toList();
      } catch (error) {
        throw (error);
      }
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Story>> fetchMyPaywalledStories() async {
    final storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];
    final url = Uri.parse(
        '${dotenv.get('API_BASE_URL')}/users/$userId/recommendations/paywalled');

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load recommend stories');
    }
  }

  Future<List<Story>> fetchMyRecommendStories() async {
    final storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final userId = JwtDecoder.decode(jwtToken as String)['user_id'];
    final url = Uri.parse(
        '${dotenv.get('API_BASE_URL')}/users/$userId/recommendations');

    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load recommend stories');
    }
  }

  Future<List<Story>> fetchSimilarStories(String storyId) async {
    final url = Uri.parse(
        '${dotenv.get('API_BASE_URL')}/stories/$storyId/recommendations');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load recommend stories');
    }
  }

  Future<Story> fetchStoryById(String storyId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url = Uri.parse('$storiesEndpoint/$storyId');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        return Story.fromJson(result);
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Chapter>?> fetchAllChaptersStoryById(String? storyId) async {
    if (storyId == null) {
      return null;
    }

    final url = Uri.parse('$storiesEndpoint/$storyId/chapters');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result.map((i) => Chapter.fromJson(i)).toList();
    } else {
      return null;
    }
  }

  Future<List<Story>> fetchStoriesByUserId(String userId) async {
    final url = Uri.parse('${Endpoints().user}/$userId/stories');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Story>?> fetchMyStories() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url =
        Uri.parse('${Endpoints().user}/me/stories?page=1&page_size=100');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Story>?> fetchPublishedStoriesByUserId(String userId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();

    String? jwtToken = await storage.read(key: 'jwt');
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url = Uri.parse('${Endpoints().user}/$userId/stories');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      // print('RES FOR PUBLISHED stories ');
      // print(' ${responseBody}');
    }
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<ReadingList>?> fetchReadingStoriesByUserId(String userId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();

    String? jwtToken = await storage.read(key: 'jwt');
    print('jwt $jwtToken');
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url = Uri.parse('${Endpoints().user}/$userId/reading-lists');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];

      return result.map((i) => ReadingList.fromJson(i)).toList();
    } else {
      return null;
    }
  }

  Future<List<Story>?> fetchTopStoriesForNewUser() async {
    final url = Uri.parse('${Endpoints().story}/sample/3');
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print('RES FOR TOP STORIES  ${response.body}');
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  //using dio package for calling PATCH request
  Future<Story?> editStory(String? storyId, body, formFile) async {
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    //sending form data
    final Map<String, String> firstMap = body;
    final Map<String, MultipartFile> secondeMap;
    //if the img does not change, do not have form_file field
    if (formFile[0] is String) {
      secondeMap = {};
    } else {
      File file = File(formFile[0].path); //import dart:io
      secondeMap = {'form_file': await MultipartFile.fromFile(file.path)};
    }

    //merge 2 map
    final Map<String, dynamic> finalMap = {};
    finalMap.addAll(firstMap);
    finalMap.addAll(secondeMap);

    final FormData formData = FormData.fromMap(finalMap);
    //create global interceptors
    // print(formData);
    try {
      final response = await dio.patch('$storiesEndpoint/$storyId',
          data: formData, options: Options(headers: header));
      print('res');
      print(response);

      final result = response.data['data']; //do not have to json decode
      return Story.fromJson(result);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('err');
        print(e.response);
      }
      return null;
    }

    // if (kDebugMode) {
    //   print('res');
    //   print(response);
    //   print(response.headers);
    //   print(response.requestOptions);
    //   print(response.statusCode);
    // }
  }

  Future<Story?> createStory(body, formFile) async {
    File file = File(formFile[0].path); //import dart:io
    final url = Uri.parse(storiesEndpoint);
    Map<String, String> header = {
      "Content-type": "multipart/form-data",
      "Accept": "application/json",
    };

    final request = http.MultipartRequest('POST', url)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath(
        'form_file',
        file.path,
      ));
    request.headers.addAll(header);
    var response = await request.send();

    final respStr = await response.stream.bytesToString();

    var encoded = jsonDecode(respStr);

    if (kDebugMode) {
      print('res');
      print(
        jsonDecode(respStr),
      );
      print(encoded['data']['chapters']);
    }

    if (encoded['code'] == 200) {
      final result = encoded['data'];
      return Story.fromJson(result);
    } else {
      return null;
      throw Exception('Failed to load stories');
    }
  }

  //buy a whole story
  Future<void> buyStory(storyId) async {
    print('STORYID :$storyId');
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final userId = JwtDecoder.decode(jwtToken as String)['user_id'];

    final url =
        Uri.parse('${Endpoints().user}/$userId/stories/$storyId/access');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.post(url, headers: header);
    print('response ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to buy story');
    }
  }

  Future<List<Profile>> fetchTopDonators(String storyId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    if (storyId == '') return [];

    final url = Uri.parse('${Endpoints().story}/$storyId/top-donators');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Profile.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
