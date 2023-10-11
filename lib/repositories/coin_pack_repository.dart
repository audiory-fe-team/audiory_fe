import 'dart:convert';

import 'package:audiory_v0/feat-manage-profile/models/CoinPack.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CoinPackRepository {
  static final coinPackEndpoint = "${dotenv.get('API_BASE_URL')}/coin-packs";
  final dio = Dio();

  Future<List<CoinPack>> fetchAllCoinPacks() async {
    final url = Uri.parse(coinPackEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => CoinPack.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load coinpacks');
    }
  }
}
