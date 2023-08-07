import 'package:audiory_v0/feat-explore/models/filter.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:audiory_v0/services/story_services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storyServices = StoryService();

final storiesProvider = FutureProvider.autoDispose
    .family<List<StoryServer>, String?>((ref, keyword) async {
  return await storyServices.fetchStories(keyword);
});
