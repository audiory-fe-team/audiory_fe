import 'dart:convert';
import 'package:audiory_v0/models/frozen_diamond/frozen_diamond_model.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthorRepository {
  static final authorEndpoint = "${dotenv.get('API_BASE_URL')}/author";

  static final userEndpoint = "${dotenv.get('API_BASE_URL')}/users";

  Future<dynamic> fetchStatus() async {
    final url = Uri.parse(
        '$authorEndpoint/stats?start_date=2023-05-05&end_date=2024-01-01');
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

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
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<dynamic> fetchRevenue() async {
    final url = Uri.parse(
        '$authorEndpoint/revenue?start_date=2023-05-05&end_date=2024-01-01');
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

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
    print(responseBody);
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<FrozenDiamond>?> fetchFrozenDiamond() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    String userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url = Uri.parse('$userEndpoint/$userId/frozen-diamonds');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => FrozenDiamond.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<dynamic> fetchTopReaders() async {
    final url = Uri.parse('$authorEndpoint/reader-ranking');
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

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
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<dynamic> fetchTopStories(
      {String startDate = '2023-01-01', String endDate = '2024-01-01'}) async {
    final url = Uri.parse(
        '$authorEndpoint/story-ranking?start_date=$startDate&end_date=$endDate');
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

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
      return result;
    } else {
      throw Exception('Failed to load stories');
    }
  }

  Future<List<Transaction>> fetchReaderTransactions(
      {int page = 1, int pageSize = 100}) async {
    final url = Uri.parse(
        '$authorEndpoint/reader-transactions?page=$page&page_size=$pageSize');
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

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
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Transaction.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
