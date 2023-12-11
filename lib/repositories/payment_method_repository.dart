import 'dart:convert';

import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:audiory_v0/models/user-payment-method/user_payment_method.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PaymentMethodRepository {
  static final paymentMethodEndpoint =
      "${dotenv.get('API_BASE_URL')}/payment-methods";
  static final myPaymentMethodEndpoint = "${dotenv.get('API_BASE_URL')}/users";
  static final withDrawalEndpoint = "${dotenv.get('API_BASE_URL')}/withdrawals";
  final dio = Dio();

  Future<List<PaymentMethod>> fetchAllPaymentMethods() async {
    final url = Uri.parse(paymentMethodEndpoint);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('res for paymenth $responseBody');
    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => PaymentMethod.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

  Future<List<UserPaymentMethod>> fetchMyPaymentMethod({userId}) async {
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    final url = Uri.parse('$myPaymentMethodEndpoint/$userId/payment-methods');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);
    print('res for paymenth $responseBody');
    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];
      return result.map((i) => UserPaymentMethod.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

  Future<dynamic> withdraw(body) async {
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    final url = Uri.parse('$withDrawalEndpoint');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    if (jwt != null) {
      header['Authorization'] = 'Bearer $jwt';
    }
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    final responseBody = utf8.decode(response.bodyBytes);
    print('res for withdraw $responseBody');
    if (response.statusCode == 200) {
      return jsonDecode(responseBody)['data']['id'];
    } else {
      throw Exception('Failed to load payment methods');
    }
  }
}
