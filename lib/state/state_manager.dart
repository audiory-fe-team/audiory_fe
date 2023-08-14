import 'package:audiory_v0/models/StoryServer.dart';
import 'package:audiory_v0/services/story.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audiory_v0/services/story_services.dart';

final storyFutureProvider = FutureProvider<List<StoryServer>>((ref) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStories();
});
