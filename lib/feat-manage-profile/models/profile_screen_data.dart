import '../../models/Profile.dart';
import '../../models/Story.dart';

class ProfileScreenData {
  final Profile? profile;
  final List<Story>? stories;
  final List<Story>? readingList;
  final List<Story>? followersList;

  ProfileScreenData(
      this.profile, this.stories, this.readingList, this.followersList);
}
