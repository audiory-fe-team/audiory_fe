import 'package:audiory_v0/models/story/story_model.dart';

import '../../models/Profile.dart';

class ProfileScreenData {
  final Profile? profile;
  final List<Story>? stories;
  final List<Story>? readingList;
  final List<Story>? followersList;

  ProfileScreenData(
      this.profile, this.stories, this.readingList, this.followersList);
}
