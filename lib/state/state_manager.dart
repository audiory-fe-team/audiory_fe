import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/services/auth_services.dart';
import 'package:audiory_v0/services/category_services.dart';
import 'package:audiory_v0/services/story.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyFutureProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStories();
});

//use .family to add an extra param to the provider
final storyByIdFutureProvider =
    FutureProvider.autoDispose.family<Story?, String>((ref, storyId) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStoriesById(storyId);
});

final allChaptersStoryByIdFutureProvider = FutureProvider.autoDispose
    .family<List<Chapter>?, String>((ref, storyId) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchAllChaptersStoryById(storyId);
});

//combine
// final storyInformationByIdFutureProvider = FutureProvider<>((ref) async {
//   final repository =  ref.watch(storyByIdFutureProvider);
//   return repository.fetchAllChaptersStoryById(storyId);
// });
final categoryFutureProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.read(categoryRepositoryProvider);
  return repository.fetchCategory();
});

final storyOfUserProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStoriesByUserId('');
});

final authUserProvider = FutureProvider<UserServer?>((ref) async {
  final repository = ref.read(authServiceProvider);
  return repository.signInWithGoogle();
});

// final detailStoryFutureProvider = FutureProvider<StoryServer>((ref) async {
//   final repository = ref.read(detaiStoryRepositoryProvider);
//   return repository.fetchStoriesById();
// });
