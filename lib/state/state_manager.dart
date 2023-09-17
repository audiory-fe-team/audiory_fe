import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Chapter.dart';
import '../models/Profile.dart';
import '../models/Story.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';

final storyFutureProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStories();
});

//use .family to add an extra param to the provider
final storyByIdFutureProvider =
    FutureProvider.autoDispose.family<Story?, String>((ref, storyId) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStoryById(storyId);
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

final storyOfUserProvider =
    FutureProvider.family<List<Story>, String>((ref, userId) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchStoriesByUserId(userId);
});

final authUserProvider = FutureProvider<UserServer?>((ref) async {
  final repository = ref.read(authServiceProvider);
  return repository.signInWithGoogle();
});

//CHAPTER

final allChaptersStoryByIdFutureProvider = FutureProvider.autoDispose
    .family<List<Chapter>?, String>((ref, storyId) async {
  final repository = ref.read(storyRepositoryProvider);
  return repository.fetchAllChaptersStoryById(storyId);
});

final chapterByIdFutureProvider =
    FutureProvider.autoDispose.family<Chapter?, String>((ref, chapterId) async {
  final repository = ref.read(chapterRepositoryProvider);
  return repository.fetchChapterDetail(chapterId);
});


//CHAPTER VERSION


