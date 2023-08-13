import 'package:audiory_v0/feat-explore/screens/ranking_screen.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:audiory_v0/services/story_services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storyServices = StoryService();

// final rankingProvider = FutureProvider.autoDispose
//     .family<List<StoryServer>, RankingType?>((ref, type) async {
//   return await storyServices.fetchStories(keyword);
// });
