import 'package:audiory_v0/feat-write/data/api/story_api.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/dio_exceptions.dart';

class StoryRepository {
  final StoryApi _storyApi;

  StoryRepository(this._storyApi);

  Future<List<Story>?> fecthStoriesByUserId(String userId) async {
    try {
      final res = await _storyApi.fetchStoriesByUserId(userId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST chapterApi : ${res.toString()}');
      }
      final stories =
          (res['data'] as List).map((e) => Story.fromJson(e)).toList();
      return stories;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }
      rethrow;
    }
  }

  Future<List<Story>?> fecthReadingListByUserId(String userId) async {
    try {
      final res = await _storyApi.fetchReadingListByUserId(userId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST chapterApi : ${res.toString()}');
      }
      final stories =
          (res['data'] as List).map((e) => Story.fromJson(e)).toList();
      return stories;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }
      rethrow;
    }
  }

  Future<bool?> deleteStory(String storyId) async {
    try {
      final res = await _storyApi.deleteStory(storyId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST storyAPi : ${res.toString()}');
      }
      if (res['code'] == '200') {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }
      rethrow;
    }
  }
}
