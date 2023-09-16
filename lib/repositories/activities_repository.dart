import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class ActivitiesRepository {
  static final activitiesEndpoint = "${dotenv.get('API_BASE_URL')}/activities";

  Future<dynamic> sendActivity(
      {required String actionEntity,
      required String actionType,
      required String entityId,
      required String userId}) async {
    final url = Uri.parse("$activitiesEndpoint");

    final response = await http.post(url, body: {
      'action_entity': actionEntity,
      'action_type': actionType,
      'entity_id': entityId,
      'user_id': userId
    });

    if (response.statusCode == 200) {
      return HttpStatus.accepted;
    } else {
      throw Exception('Failed to send activity');
    }
  }
}
