//api : get the raw json data from the api
//repository : convert json to model

import 'package:audiory_v0/core/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChapterVersionApi {
  static final chapterVersionEndpoint =
      "${dotenv.get('API_BASE_URL')}/chapter-version";

  final DioClient _dioClient;

  ChapterVersionApi(this._dioClient);

  //get all chapter versions of chapter

  Future<Map<String, dynamic>> fetchChapterVersionByChapterVersionId(
      String chapterVersionId) async {
    try {
      final res =
          await _dioClient.get('$chapterVersionEndpoint/$chapterVersionId');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createChapterVersion() async {
    try {
      final res = await _dioClient.post(chapterVersionEndpoint);
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> revertChapterVersionByChapterVersionId(
      String chapterVersionId) async {
    try {
      final res = await _dioClient
          .post('$chapterVersionEndpoint/revert/$chapterVersionId');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
