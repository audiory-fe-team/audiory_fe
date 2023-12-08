import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/models/report/report_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  static final reportEndpoint = dotenv.get('API_BASE_URL');

  static Future<Report> fetchReportById(String reportId) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    final url = Uri.parse('$reportEndpoint/reports/$reportId');
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        return Report.fromJson(result);
      } catch (error) {
        print(error);
        throw (error);
      }
    } else {
      throw Exception('Failed to load report');
    }
  }

  static Future<dynamic> addReport(body, formFile) async {
    final url = Uri.parse('$reportEndpoint/reports');

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

    var request;
    if (formFile != null) {
      File file = File(formFile.path); //import dart:io

      request = http.MultipartRequest('POST', url)
        ..fields.addAll(body)
        ..files.add(await http.MultipartFile.fromPath(
          'form_file',
          file.path,
        ));
    } else {
      request = http.MultipartRequest('POST', url)..fields.addAll(body);
    }
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
