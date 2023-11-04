import 'dart:convert';

import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class CoinPackRepository {
  static final coinPackEndpoint = "${dotenv.get('API_BASE_URL')}/coin-packs";
  static final coinStoreEndpoint = "${dotenv.get('API_BASE_URL')}/coin-store";
  final dio = Dio();

  Future<List<CoinPack>> fetchMyCoinStore() async {
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');
    final url = Uri.parse(coinStoreEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      print('jwt ${jwtToken.toString()}');
      header['Authorization'] = 'Bearer $jwtToken';
    }
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'] ?? [];
      return result.map((i) => CoinPack.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load coin store');
    }
  }
}
