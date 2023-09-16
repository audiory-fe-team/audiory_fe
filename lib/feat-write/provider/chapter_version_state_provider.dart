import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';
import 'package:audiory_v0/feat-write/provider/chapter_provider.dart';
import 'package:audiory_v0/feat-write/provider/chapter_version_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterVersionsNotifier extends StateNotifier<List<ChapterVersion>> {
  // Fetching all products whenever anyone starts listning.
  // Passing Ref, in order to access other providers inside this.
  ChapterVersionsNotifier({required this.ref, required this.chapterId})
      : super([]) {
    fetchChapterVersions(ref: ref);
  }
  final Ref ref;
  final String chapterId;

  Future fetchChapterVersions({required Ref ref}) async {
    await ref
        .read(chapterRepositoryProvider)
        .fetchChapterVersionsByChapterId(chapterId)
        .then((value) {
      // Setting current `state` to the fetched list of products.
      state = value;
      // Setting isLoading to `false`.
      ref.read(isLoadingChapterVersionsProvider.notifier).state = false;
    });
  }
}
