import '../../../core/network/constant/endpoints.dart';
import '../../../core/network/dio_client.dart';

class StoryApi {
  final DioClient _dioClient;

  StoryApi(this._dioClient);

  Future<Map<String, dynamic>> fetchStoriesByUserId(String userId) async {
    try {
      final res = await _dioClient.get('${Endpoints().user}/$userId/stories');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchReadingListByUserId(String userId) async {
    try {
      final res =
          await _dioClient.get('${Endpoints().user}/$userId/reading-lists');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteStory(String storyId) async {
    try {
      final res = await _dioClient.delete('${Endpoints().story}/$storyId');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> unPublishStory(String storyId) async {
    try {
      final res = await _dioClient.put('${Endpoints().story}/$storyId');
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
