class Paragraph {
  final String id;
  final String chapter_id;
  final int order;
  final String content;
  final int comment_count;
  final String?
      comments; // It could be a List or null, depending on your API response
  final String audio_url;

  Paragraph({
    required this.id,
    required this.chapter_id,
    required this.order,
    required this.content,
    required this.comment_count,
    this.comments,
    required this.audio_url,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      id: json["id"],
      chapter_id: json["chapter_id"],
      order: json["order"],
      content: json["content"],
      comment_count: json["comment_count"],
      comments: json["comments"],
      audio_url: json["audio_url"],
    );
  }
}
