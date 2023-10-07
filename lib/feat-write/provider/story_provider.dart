import 'package:audiory_v0/core/network/dio_client.dart';
import 'package:audiory_v0/core/shared_provider/shared_provider.dart';
import 'package:audiory_v0/feat-write/data/api/story_api.dart';
import 'package:audiory_v0/feat-write/data/repositories/story_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/chapter_api.dart';
import '../states/story_state.dart';

final storyApiProvider = Provider<StoryApi>((ref) {
  return StoryApi(ref.read(dioClientProvider));
});

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository(ref.read(storyApiProvider));
});
