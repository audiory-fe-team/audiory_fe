import 'dart:convert';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/gift/gift_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class GiftRepository {
  static final giftEndpoint = "${dotenv.get('API_BASE_URL')}/gifts";
  final dio = Dio();

  Future<List<Gift>> fetchAllGifts() async {
    final url = Uri.parse(giftEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => Gift.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load coinpacks');
    }
  }

  Future<void> donateGift(storyId, body) async {
    const storage = FlutterSecureStorage();
    var jwtToken = await storage.read(key: 'jwt');
    var userId = JwtDecoder.decode(jwtToken as String)['user_id'];

    final url =
        Uri.parse('${Endpoints().user}/$userId/stories/$storyId/donate');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = jwtToken;
    }
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    print('STORY ID ${storyId}');
    print('BODY ${body}');
    print('RESPONSE ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to donate gift');
    }
  }
}
