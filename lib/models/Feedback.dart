class AppFeedback {
  final String id;
  final String? storyId;
  final String? userId;
  final String? eventType;
  AppFeedback({required this.id, this.storyId, this.userId, this.eventType});

  factory AppFeedback.fromJson(Map<String, dynamic> json) {
    return AppFeedback(
        id: json["id"],
        storyId: json["story_id"],
        userId: json["usre_id"],
        eventType: json['event_type']);
  }
}
