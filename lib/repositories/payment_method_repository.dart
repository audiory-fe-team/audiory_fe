import 'dart:convert';

import 'package:audiory_v0/feat-manage-profile/models/PaymentMethod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PaymentMethodRepository {
  static final paymentMethodEndpoint =
      "${dotenv.get('API_BASE_URL')}/payment-methods";
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
}
