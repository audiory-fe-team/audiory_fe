import 'package:audiory_v0/models/Paragraph.dart';

class Chapter {
  final String id;
  final String story_id;
  final String? current_version_id;
  final String?
      product_id; // It could be null or a String, depending on your API response
  final String title;
  final bool is_draft;
  final bool is_paywalled;
  final int author_earning;
  final int read_count;
  final int vote_count;
  final int comment_count;
  final String created_date;
  final String updated_date;
  final bool is_enabled;
  final String?
      chapter_version; // It could be null or a String, depending on your API response
  final List<Paragraph> paragraphs;

  Chapter({
    required this.id,
    required this.story_id,
    required this.current_version_id,
    required this.product_id,
    required this.title,
    required this.is_draft,
    required this.is_paywalled,
    required this.author_earning,
    required this.read_count,
    required this.vote_count,
    required this.comment_count,
    required this.created_date,
    required this.updated_date,
    required this.is_enabled,
    required this.chapter_version,
    required this.paragraphs,
  });

  // Factory constructor to create a Chapter from JSON
  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<dynamic> paragraphList = json["paragraphs"] ?? [];
    List<Paragraph> paragraphs =
        paragraphList.map((p) => Paragraph.fromJson(p)).toList();

    return Chapter(
      id: json["id"],
      story_id: json["story_id"],
      current_version_id: json["current_version_id"] ?? 'null',
      product_id: json["product_id"] ?? 'null',
      title: json["title"],
      is_draft: json["is_draft"],
      is_paywalled: json["is_paywalled"],
      author_earning: json["author_earning"],
      read_count: json["read_count"],
      vote_count: json["vote_count"],
      comment_count: json["comment_count"],
      created_date: json["created_date"],
      updated_date: json["updated_date"],
      is_enabled: json["is_enabled"],
      chapter_version: json["chapter_version"] ?? 'null',
      paragraphs: paragraphs,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "story_id": story_id,
        "current_version_id": current_version_id,
        "product_id": product_id,
        "title": title,
        "is_draft": is_draft,
        "is_paywalled": is_paywalled,
        "author_earning": author_earning,
        "read_count": read_count,
        "vote_count": vote_count,
        "comment_count": comment_count,
        "created_date": created_date,
        "updated_date": updated_date,
        "is_enabled": is_enabled,
        "chapter_version": chapter_version,
        "paragraphs":
            paragraphs.map((paragraph) => paragraph.toJson()).toList(),
      };
}
