import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/services/chapter_services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chapterServices = ChapterServices();

final chapterProvider =
    FutureProvider.autoDispose.family<Chapter, String?>((ref, id) async {
  return await chapterServices.fetchChapterDetail(id);
});
