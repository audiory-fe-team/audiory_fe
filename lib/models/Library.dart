import 'package:audiory_v0/models/LibraryStory.dart';
import 'package:audiory_v0/models/Story.dart';

class Library {
  final String id;
  final List<LibraryStory>? libraryStory;
  final int? numberOfStories;
  final String? userId;
  final List<Story>? stories;

  Library({
    required this.id,
    required this.libraryStory,
    required this.numberOfStories,
    required this.userId,
    required this.stories,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    List<dynamic> libStoryJsonList = json['library_story'] ?? [];
    List<LibraryStory> libStories = (libStoryJsonList ?? [])
        .map((libStoryJson) => LibraryStory.fromJson(libStoryJson))
        .toList();

    List<dynamic> storiesJsonList = json['stories'] ?? [];
    List<Story> stories =
        (storiesJsonList ?? []).map((story) => Story.fromJson(story)).toList();

    return Library(
      id: json['id'],
      libraryStory: libStories,
      numberOfStories: json['number_of_stories'],
      userId: json['userId'],
      stories: stories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'library_story': libraryStory?.map((e) => e.toJson()).toList(),
      'number_of_stories': numberOfStories,
      'user_id': userId,
      'stories': stories?.map((e) => e.toJson()).toList(),
    };
  }
}
