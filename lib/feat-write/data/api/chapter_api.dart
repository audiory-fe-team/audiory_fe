//api : get the raw json data from the api
//repository : convert json to model

import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:audiory_v0/core/network/dio_client.dart';

import '../../../models/Story.dart';

class ChapterApi {
  final DioClient _dioClient;

  ChapterApi(this._dioClient);

  Future<Map<String, dynamic>> fetchChapterById(String chapterId) async {
    try {
      final res = await _dioClient.get('${Endpoints().chapter}/$chapterId');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createChapter(Story story) async {
    try {
      final res = await _dioClient.post(Endpoints().chapter,
          data: {'position': story.chapters?.length, 'story_id': story.id});
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchChapterVersionsOfChapter(
      String chapterId) async {
    try {
      final res = await _dioClient
          .get('${Endpoints().chapter}/$chapterId/chapter-version');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
