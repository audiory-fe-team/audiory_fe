import 'package:audiory_v0/models/story/story_model.dart';

class ReadingList {
  final String id;
  final String userId;
  final String name;
  final String coverUrl;
  final bool isPrivate;
  final String createdDate;
  final String updatedDate;
  final bool isEnabled;
  final List<Story>? stories;

  ReadingList({
    required this.id,
    required this.userId,
    required this.name,
    required this.coverUrl,
    required this.isPrivate,
    required this.createdDate,
    required this.updatedDate,
    required this.isEnabled,
    this.stories,
  });

  factory ReadingList.fromJson(Map<String, dynamic> json) {
    List<dynamic> storiesJson = json["stories"] ?? [];
    List<Story> stories = storiesJson.map((p) => Story.fromJson(p)).toList();

    return ReadingList(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      coverUrl: json['cover_url'],
      isPrivate: json['is_private'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      isEnabled: json['is_enabled'],
      stories: stories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'cover_url': coverUrl,
      'is_private': isPrivate,
      'created_date': createdDate,
      'updated_date': updatedDate,
      'is_enabled': isEnabled,
      'stories': stories?.map((story) => story.toJson()).toList(),
    };
  }
}
