import 'dart:convert';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/Transaction.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  static Future<List<Transaction>?> fetchAllTransactions() async {
    final url = Uri.parse(Endpoints().transaction);

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    // const storage = FlutterSecureStorage();
    // String? jwtToken = await storage.read(key: 'jwt');
    // if (jwtToken != null) {
    //   headers['Authorization'] = 'Bearer $jwtToken';
    // }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => Transaction.fromJson(i)).toList();
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to load user info');
    }
  }

  static Future<List<Transaction>?> fetchMyTransactions() async {
    final url = Uri.parse('${Endpoints().user}/me/transactions');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = jsonDecode(responseBody)['data'];
        return result.map((i) => Transaction.fromJson(i)).toList();
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
