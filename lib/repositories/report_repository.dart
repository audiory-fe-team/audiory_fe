import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  static final reportEndpoint = dotenv.get('API_BASE_URL');

  static Future<dynamic> addReport(body, formFile) async {
    final url = Uri.parse('$reportEndpoint/reports');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    File file = File(formFile[0].path); //import dart:io

    final request = http.MultipartRequest('POST', url)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath(
        'form_file',
        file.path,
      ));
    request.headers.addAll(headers);

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final result = jsonDecode(respStr)['data'];
      return result;
    } else {
      throw Exception('Failed to create report');
    }
  }
}
