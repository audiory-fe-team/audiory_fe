import 'dart:convert';

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
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

  static Future<List<Transaction>?> fetchMyTransactions({
    TransactionType? type,
    int? page = 1,
    int? pageSize = 20,
  }) async {
    String transactionEndpoint =
        '${Endpoints().user}/me/transactions?page=$page&page_size=$pageSize';
    if (type != null) {
      transactionEndpoint += '&type=${type.name}';
    }
    final url = Uri.parse(transactionEndpoint);
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

  static Future<Transaction?> fetchTransaction(id) async {
    String transactionEndpoint = '${Endpoints().transaction}/$id';
    final url = Uri.parse(transactionEndpoint);
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
    print('transaction');
    print(responseBody);

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        return Transaction.fromJson(result);
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
