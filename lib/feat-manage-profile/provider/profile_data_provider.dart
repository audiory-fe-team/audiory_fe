import 'package:audiory_v0/core/network/dio_client.dart';
import 'package:audiory_v0/feat-manage-profile/data/api/profile_api.dart';
import 'package:audiory_v0/feat-manage-profile/data/repositories/profile_repository.dart';
import 'package:audiory_v0/feat-manage-profile/models/profile_screen_data.dart';
import 'package:audiory_v0/feat-write/data/api/story_api.dart';
import 'package:audiory_v0/feat-write/data/repositories/story_repository.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/Story.dart';

final userProfileAllDataProvider = StateNotifierProvider.autoDispose<
    ProfileNotifier, AsyncValue<ProfileScreenData>>((ref) => ProfileNotifier());

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileScreenData>> {
  ProfileNotifier() : super(const AsyncValue.loading());

  final _profileRepository = ProfileRepository(ProfileApi(DioClient(Dio())));
  final _storyRepository = StoryRepository(StoryApi(DioClient(Dio())));
  final _readingRepository = StoryRepository(StoryApi(DioClient(Dio())));
  void init(String userId) async {
    try {
      final Profile? user =
          await _profileRepository.fecthProfileByUserId(userId);

      final List<Story>? stories =
          await _storyRepository.fecthStoriesByUserId(userId);

      final List<Story>? readingList =
          await _storyRepository.fecthReadingListByUserId(userId);

      if (kDebugMode) {
        print('user, $user');
        print('story , $stories');
        print('readingList , $readingList');
      }

      state =
          AsyncValue.data(ProfileScreenData(user, stories, readingList, []));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
