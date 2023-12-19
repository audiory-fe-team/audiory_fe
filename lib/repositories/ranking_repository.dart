import 'dart:convert';

import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class RankingRepository {
  static final storiesEndpoint = "${dotenv.get('API_BASE_URL')}/ranking";

  Future<List<Story>> fetchRankingStories(
      {required RankingMetric metric,
      required RankingTimeRange time,
      String? category_id,
      int? offset,
      int? limit}) async {
    final url = Uri.parse("$storiesEndpoint/stories").replace(queryParameters: {
      'sort_by': getValueString(metric.toString()),
      'time_range': getValueString(time.toString()),
      if (category_id != null) 'category_id': category_id,
      'offset': (offset ?? 0).toString(),
      'limit': (limit ?? 5).toString(),
    });
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Story.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load ranking stories');
    }
  }

  Future<List<Profile>> fetchRankingAuthors(
      {required RankingTimeRange time,
      required RankingMetric metric,
      String? category,
      int? offset}) async {
    final url = Uri.parse("$storiesEndpoint/authors").replace(queryParameters: {
      'sort_by': getValueString(metric.toString()),
      'time_range': getValueString(time.toString()),
      // 'category': category,
      'offset': (offset ?? 0).toString(),
      'limit': 10.toString(),
    });
    final response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(responseBody)['data'];
      return result.map((i) => Profile.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load ranking stories');
    }
  }
}
