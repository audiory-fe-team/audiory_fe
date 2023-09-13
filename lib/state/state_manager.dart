import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/repositories/category.repository.dart';
import 'package:audiory_v0/repositories/story.repository.dart';
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