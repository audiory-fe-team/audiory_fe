import 'package:audiory_v0/feat-write/data/models/chapter_model/chapter_model.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class OfflineDatabase {
  static final OfflineDatabase _singleton = OfflineDatabase._internal();

  factory OfflineDatabase() {
    return _singleton;
  }

  OfflineDatabase._internal() {
    _openDatabase();
  }

  late Database _database;
  final StoreRef<String, Map<String, dynamic>> _storeStories =
      stringMapStoreFactory.store('stories');
  final StoreRef<String, Map<String, dynamic>> _storeChapters =
      stringMapStoreFactory.store('chapters');

  Future<void> _openDatabase() async {
    _database = await databaseFactoryIo.openDatabase('audiory_database.db');
  }

  Future<void> saveStory(Story story) async {
    final storyJson = story.toJson();
    await _storeStories.record(story.id).put(_database, storyJson);
  }

  Future<void> saveChapters(Chapter chapter) async {
    final chapterJson = chapter.toJson();
    await _storeChapters.record(chapter.id).put(_database, chapterJson);
  }

  Future<void> deleteStory(String storyId) async {
    await _storeStories.record(storyId).delete(_database);
  }

  Future<Story?> getStory(String storyId) async {
    final storyJson = await _storeStories.record(storyId).get(_database);
    if (storyJson == null) return null;
    return Story.fromJson(storyJson);
  }

  Future<Chapter?> getChapter(String chapterId) async {
    final chapterJson = await _storeChapters.record(chapterId).get(_database);
    if (chapterJson == null) return null;
    return Chapter.fromJson(chapterJson);
  }

  Future<List<Story>> getAllStories() async {
    final records = await _storeStories.find(_database);
    return records.map((record) => Story.fromJson(record.value)).toList();
  }
}
