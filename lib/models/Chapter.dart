import 'package:audiory_v0/models/Paragraph.dart';

class Chapter {
  final String id;
  final String storyId;
  final String? currentVersionId;
  final String?
      productId; // It could be null or a String, depending on your API response
  final String title;
  final bool? isDraft;
  final bool? isPaywalled;
  final int? authorEarning;
  final int? readCount;
  final int? position;
  final int? voteCount;
  final int? commentCount;
  final String? createdDate;
  final String? updatedDate;
  final bool? isEnabled;
  final dynamic
      chapterVersion; // It could be null or a String, depending on your API response
  final List<Paragraph>? paragraphs;

  Chapter({
    required this.id,
    required this.storyId,
    this.currentVersionId,
    this.productId,
    required this.title,
    this.isDraft,
    this.isPaywalled,
    this.authorEarning,
    this.position,
    this.readCount,
    this.voteCount,
    this.commentCount,
    this.createdDate,
    this.updatedDate,
    this.isEnabled,
    this.chapterVersion,
    this.paragraphs,
  });

  // Factory constructor to create a Chapter from JSON
  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<dynamic> paragraphList = json["paragraphs"] ?? [];
    List<Paragraph> paragraphs =
        paragraphList.map((p) => Paragraph.fromJson(p)).toList();

    return Chapter(
      id: json["id"],
      storyId: json["story_id"],
      currentVersionId: json["current_version_id"] ?? 'null',
      productId: json["product_id"] ?? 'null',
      title: json["title"],
      isDraft: json["is_draft"],
      isPaywalled: json["is_paywalled"],
      authorEarning: json["author_earning"],
      position: json["position"],
      readCount: json["read_count"],
      voteCount: json["vote_count"],
      commentCount: json["comment_count"],
      createdDate: json["created_date"],
      updatedDate: json["updated_date"],
      isEnabled: json["is_enabled"],
      chapterVersion: json["chapter_version"] ?? 'null',
      paragraphs: paragraphs,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "story_id": storyId,
        "current_version_id": currentVersionId,
        "product_id": productId,
        "title": title,
        "is_draft": isDraft,
        "is_paywalled": isPaywalled,
        "author_earning": authorEarning,
        "position": position,
        "read_count": readCount,
        "vote_count": voteCount,
        "comment_count": commentCount,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "is_enabled": isEnabled,
        "chapter_version": chapterVersion,
        "paragraphs":
            paragraphs?.map((paragraph) => paragraph.toJson()).toList(),
      };
}
