import 'package:audiory_v0/core/network/dio_client.dart';
import 'package:audiory_v0/feat-write/data/api/story_api.dart';
import 'package:audiory_v0/feat-write/data/repositories/story_repository.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audiory_v0/models/Story.dart';

final storyDataProvider = StateNotifierProvider.autoDispose<StoryDataNotifier,
    AsyncValue<List<Story>?>>((ref) => StoryDataNotifier());

class StoryDataNotifier extends StateNotifier<AsyncValue<List<Story>?>> {
  StoryDataNotifier() : super(const AsyncValue.loading());

  final _storyRepository = StoryRepository(StoryApi(DioClient(Dio())));

  void fetchStoriesByUserId(String userId) async {
    // state = const AsyncValue.loading();
    try {
      final List<Story>? stories =
          await _storyRepository.fecthStoriesByUserId(userId);

      if (kDebugMode) {
        print('user, $userId');
        print('story , $stories');
      }

      state = AsyncValue.data(stories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void deleteStoryOfUser(Story? story) async {
    // state = const AsyncValue.loading();
    try {
      final bool? isDeleted =
          await _storyRepository.deleteStory(story?.id as String);

      if (kDebugMode) {
        print('state $state');
      }
      state = state.whenData((value) =>
          value!.where((element) => element.id != story?.id).toList());
      //error here
      // state = AsyncValue.data(state.when(
      //     data: (data) => data,
      //     error: (err, st) {
      //       print(err);
      //     },
      //     loading: () {
      //       print('loading');
      //     }));

      // state = AsyncValue.data([
      //   await for (final item in AsyncValue.data(state) as dynamic)
      //     if (item.id != story?.id) item,
      // ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void addStory(Story? story) async {
    try {
      // final Story newStory= await _storyRepository
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void unPublishStoryOfUser(Story? story) async {
    // state = const AsyncValue.loading();
    try {
      final bool? isDeleted =
          await _storyRepository.deleteStory(story?.id as String);

      if (kDebugMode) {
        // print('is Delete , $isDeleted');
        print('state $state');
      }

      //error here
      // state = AsyncValue.data(state.when(
      //     data: (data) => data,
      //     error: (err, st) {
      //       print(err);
      //     },
      //     loading: () {
      //       print('loading');
      //     }));

      // state = AsyncValue.data([
      //   await for (final item in AsyncValue.data(state) as dynamic)
      //     if (item.id != story?.id) item,
      // ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
