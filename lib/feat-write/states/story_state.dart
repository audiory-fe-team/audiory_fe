import 'dart:async';

import 'package:audiory_v0/feat-write/provider/story_provider.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoriesNotifier extends StateNotifier<AsyncValue<List<Story>>> {
  StoriesNotifier({required this.ref, this.args = ''})
      : super(const AsyncValue.loading()) {
    _retrieveStories(ref: ref);
    _removeStory(ref: ref);
  }

  final Ref ref;
  final dynamic args;
  AsyncValue<List<Story>>? previousState;

  void _cacheState() {
    previousState = state;
  }

  Future<void> _retrieveStories({required Ref ref}) async {
    state = const AsyncLoading();

    try {
      // read the repository using ref
      final storyRepository = ref.read(storyRepositoryProvider);
      state = await AsyncValue.guard(() => storyRepository
          .fecthStoriesByUserId(args as String) as Future<List<Story>>);
    } on DioException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _removeStory({required Ref ref}) async {
    if (kDebugMode) {
      print('inside dlete');
    }
    // _cacheState();

    state.maybeWhen(
      data: (stories) {
        state = AsyncValue<List<Story>>.data(
            stories.where((story) => story.id != args as String).toList());
      },
      orElse: () {},
    );
    // state = const AsyncLoading();

    try {
      // read the repository using ref
      final storyRepository = ref.read(storyRepositoryProvider);

      state = await AsyncValue.guard(() =>
          storyRepository.deleteStory(args as String) as Future<List<Story>>);
    } on DioException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
