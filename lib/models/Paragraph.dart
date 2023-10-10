class Paragraph {
  final String id;
  final String? chapterId;
  final int? order;
  final String? content;
  final int? commentCount;
  final String? audioUrl;

  const Paragraph({
    required this.id,
    required this.chapterId,
    required this.order,
    this.content,
    this.commentCount,
    required this.audioUrl,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      id: json["id"],
      chapterId: json["chapter_id"],
      order: json["order"],
      content: json["content"],
      commentCount: json["comment_count"],
      audioUrl: json["audio_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "order": order,
        "content": content,
        "comment_count": commentCount,
        "audio_url": audioUrl,
      };
}
