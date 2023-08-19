import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/services/category_services.dart';
import 'package:audiory_v0/services/story.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyFutureProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStories();
});

final categoryFutureProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.read(categoryRepositoryProvider);
  return repository.fetchCategory();
});

// final detailStoryFutureProvider = FutureProvider<StoryServer>((ref) async {
//   final repository = ref.read(detaiStoryRepositoryProvider);
//   return repository.fetchStoriesById();
// });