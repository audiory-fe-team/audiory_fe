import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/providers/offline_database.dart';
import 'package:sembast/sembast.dart';

class ChapterDatabase {
  static const String CHAPTER_DB_NAME = 'chapters';

  final chapterStore = stringMapStoreFactory.store(CHAPTER_DB_NAME);

  Future<Database> get _db async => await OfflineDatabase.instance.database;

  Future<void> saveChapters(Chapter chapter) async {
    final chapterJson = chapter.toJson();
    await chapterStore.record(chapter.id).put(await _db, chapterJson);
  }

  Future<Chapter?> getChapter(String chapterId) async {
    final chapterJson = await chapterStore.record(chapterId).get(await _db);
    if (chapterJson == null) return null;
    try {
      final chapter = Chapter.fromJson(chapterJson);
      return chapter;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
