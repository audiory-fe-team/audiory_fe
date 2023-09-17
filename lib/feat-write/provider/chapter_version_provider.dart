//create provider for api and repository

import 'package:audiory_v0/core/shared_provider/shared_provider.dart';
import 'package:audiory_v0/feat-write/data/api/chapter_version_api.dart';
import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/chapter_version_repository.dart';
import 'chapter_version_state_provider.dart';

final chapterVersionApiProvider = Provider<ChapterVersionApi>((ref) {
  return ChapterVersionApi(ref.read(dioClientProvider));
});

final chapterVersionRepositoryProvider =
    Provider<ChapterVersionRepository>((ref) {
  return ChapterVersionRepository(ref.read(chapterVersionApiProvider));
});

final chapterVersionByIdFutureProvider = FutureProvider.autoDispose
    .family<ChapterVersion?, String>((ref, chapterId) async {
  final repository = ref.read(chapterVersionRepositoryProvider);
  return repository.fetchChapterVersionByChapterVersionId(chapterId);
});
//for state
//autoDispose : A common use case is to destroy the state of a provider when it is no-longer used.
// state : list and has change
final chapterVersionDataProvider = StateNotifierProvider.autoDispose
    .family<ChapterVersionsNotifier, List<ChapterVersion>, String>(
        (ref, chapterId) {
  return ChapterVersionsNotifier(ref: ref, chapterId: chapterId);
});

final isLoadingChapterVersionsProvider = StateProvider<bool>((ref) {
  return true;
});
