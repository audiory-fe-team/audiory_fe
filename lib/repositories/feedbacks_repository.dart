import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/Feedback.dart';

class FeedbackRepository {
  static final feedbackEndpoint = Endpoints().feedback;
  final dio = Dio();
  Future<AppFeedback?> createFeedback(body) async {
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await dio.post(feedbackEndpoint,
        options: Options(headers: header), data: body);
    final result = response.data;
    if (kDebugMode) {
      print(' AppFeedback RES $result');
    }
    if (response.statusCode == 200) {
      AppFeedback newAppFeedback = AppFeedback.fromJson(result['data']);
      return newAppFeedback;
    } else {
      throw Exception('Failed to load stories');
    }
  }
}

class AppAppFeedback {}
