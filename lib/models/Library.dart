import 'package:audiory_v0/models/LibraryStory.dart';

class Library {
  final String id;
  final List<LibraryStory>? libraryStory;
  final int? numberOfStories;
  final String? userId;

  Library({
    required this.id,
    required this.libraryStory,
    required this.numberOfStories,
    required this.userId,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    List<dynamic> libStoryJsonList = json['library_story'] ?? [];
    List<LibraryStory> libStories = libStoryJsonList
        .map((libStoryJson) => LibraryStory.fromJson(libStoryJson))
        .toList();

    return Library(
      id: json['id'],
      libraryStory: libStories,
      numberOfStories: json['number_of_stories'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'library_story': libraryStory?.map((e) => e.toJson()).toList(),
      'number_of_stories': numberOfStories,
      'user_id': userId,
    };
  }
}
