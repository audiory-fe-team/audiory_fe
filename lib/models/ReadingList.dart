class ReadingList {
  final String id;
  final String? userId;
  final String? name;
  final String? coverUrl;
  final bool? isPrivate;
  final int? storyCount;
  final bool? isEnabled;
  final bool? createdDate;
  final bool? updatedDate;

  const ReadingList(
      {required this.id,
      this.userId,
      this.name,
      this.coverUrl,
      this.isPrivate,
      this.storyCount,
      this.isEnabled,
      this.createdDate,
      this.updatedDate});

  factory ReadingList.fromJson(Map<String, dynamic> json) {
    return ReadingList(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      coverUrl: json["cover_url"],
      isEnabled: json["is_enabled"],
      isPrivate: json["is_private"],
      storyCount: json["story_count"],
      createdDate: json["created_date"],
      updatedDate: json["updated_date"],
    );
  }
}
