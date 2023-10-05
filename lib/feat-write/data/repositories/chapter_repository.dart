import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/dio_exceptions.dart';
import '../../../models/Story.dart';
import '../api/chapter_api.dart';

class ChapterRepository {
  final ChapterApi _chapterApi;

  ChapterRepository(this._chapterApi);

  Future<Chapter?> createChapter(Story story) async {
    try {
      final res = await _chapterApi.createChapter(story);
      if (kDebugMode) {
        print('RESPONSE for REQUEST chapterApi : ${res.toString()}');
      }
      final chapter = Chapter.fromJson(res);
      return chapter;
    } on DioException catch (e) {
      if (e.response!.statusCode != 200) {
        if (kDebugMode) {
          print('STATUS ${e.response!.statusCode}');
        }
      } else {
        if (kDebugMode) {
          print('ERROR ${e.message} on REQUEST ${e.requestOptions}');
        }
      }
      rethrow;
    }
  }

  Future<Chapter> fetchChapterById(String chapterId) async {
    try {
      final res = await _chapterApi.fetchChapterById(chapterId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST chapterApi : ${res.toString()}');
      }
      final chapter = Chapter.fromJson(res);
      return chapter;
    } on DioException catch (e) {
      if (e.response!.statusCode != 200) {
        if (kDebugMode) {
          print('STATUS ${e.response!.statusCode}');
        }
      } else {
        if (kDebugMode) {
          print('ERROR ${e.message} on REQUEST ${e.requestOptions}');
        }
      }
      rethrow;
    }
  }

  Future<List<ChapterVersion>> fetchChapterVersionsByChapterId(
      String chapterId) async {
    try {
      final res = await _chapterApi.fetchChapterVersionsOfChapter(chapterId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST chapterApi : ${res.toString()}');
      }

      final chapterVersions =
          (res['data'] as List).map((e) => ChapterVersion.fromJson(e)).toList();
      return chapterVersions;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }
      rethrow;
    }
  }
}
