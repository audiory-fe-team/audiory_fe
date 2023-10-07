import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/offline_database.dart';
import 'package:sembast/sembast.dart';

class StoryDatabase {
  static const String STORY_DB_NAME = 'stories';

  final storyStore = stringMapStoreFactory.store(STORY_DB_NAME);

  Future<Database> get _db async => await OfflineDatabase.instance.database;

  Future<void> saveStory(Story story) async {
    final storyJson = story.toJson();
    print(story.toJson());
    // await storyStore.record(story.id).put(await _db, storyJson);
  }

  Future<void> deleteStory(String storyId) async {
    await storyStore.record(storyId).delete(await _db);
  }

  Future<Story?> getStory(String storyId) async {
    final storyJson = await storyStore.record(storyId).get(await _db);
    if (storyJson == null) return null;
    return Story.fromJson(storyJson);
  }

  Future<List<Story>> getAllStories() async {
    final records = await storyStore.find(await _db);
    return records.map((record) => Story.fromJson(record.value)).toList();
  }
}
