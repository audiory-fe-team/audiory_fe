import 'dart:convert';

import 'package:audiory_v0/feat-manage-profile/models/Purchase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PurchaseRepository {
  static final purchaseEndpoint = "${dotenv.get('API_BASE_URL')}/purchases";
  final dio = Dio();

  Future<List<Purchase>> fetchAllPurchases() async {
    final url = Uri.parse(purchaseEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => Purchase.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load Purchases');
    }
  }

  //create new purchase
  Future<String?> createPurchase(body) async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    final url = Uri.parse(purchaseEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwtToken != null) {
      header['Authorization'] = 'Bearer $jwtToken';
    }
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    // final responseBody = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print('jwt $jwtToken');
      print('BODY PURCHASE   ${response.body}');
    }
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['data'];
      print(result);
      print('applink ${result['applink']}');
      return result['applink'];

      // return Purchase.fromJson(result);
    } else {
      throw Exception('Failed to load Purchases');
    }
  }
}
