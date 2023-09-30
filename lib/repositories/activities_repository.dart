import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ActivitiesRepository {
  static final activitiesEndpoint = "${dotenv.get('API_BASE_URL')}/activities";

  static Future<dynamic> sendActivity({
    required String actionEntity,
    required String actionType,
    required String entityId,
  }) async {
    final url = Uri.parse(activitiesEndpoint);
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt_token');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };

    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.post(url,
        body: {
          'action_entity': actionEntity,
          'action_type': actionType,
          'entity_id': entityId,
        },
        headers: headers);

    if (response.statusCode == 200) {
      return HttpStatus.accepted;
    } else {
      throw Exception('Failed to send activity');
    }
  }
}
