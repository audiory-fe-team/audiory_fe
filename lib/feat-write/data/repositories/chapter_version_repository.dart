import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api/chapter_version_api.dart';
import '../models/chapter_version_model/chapter_version_model.dart';

class ChapterVersionRepository {
  final ChapterVersionApi _chapterVersionApi;

  ChapterVersionRepository(this._chapterVersionApi);

  Future<ChapterVersion> fetchChapterVersionByChapterVersionId(
      String chapterVersionId) async {
    try {
      final res = await _chapterVersionApi
          .fetchChapterVersionByChapterVersionId(chapterVersionId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST ChapterVersionApi : ${res.toString()}');
      }
      final chapterVersion = ChapterVersion.fromJson(res);
      return chapterVersion;
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

  Future<ChapterVersion> revertChapterVersionByChapterVersionId(
      String chapterVersionId) async {
    try {
      final res = await _chapterVersionApi
          .revertChapterVersionByChapterVersionId(chapterVersionId);
      if (kDebugMode) {
        print('RESPONSE for REQUEST ChapterVersionApi : ${res.toString()}');
      }
      final chapterVersion = ChapterVersion.fromJson(res);
      return chapterVersion;
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

  Future<ChapterVersion> createChapterVersion() async {
    try {
      final res = await _chapterVersionApi.createChapterVersion();
      if (kDebugMode) {
        print('RESPONSE for REQUEST ChapterVersionApi : ${res.toString()}');
      }
      final chapterVersion = ChapterVersion.fromJson(res);
      return chapterVersion;
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
}
