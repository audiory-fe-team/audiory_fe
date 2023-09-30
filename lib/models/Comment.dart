import 'package:audiory_v0/models/Profile.dart';

class Comment {
  final String chapterId;
  final List<Comment>? children;
  final String? createdDate;
  final String id;
  final bool? isEnabled;
  final bool? isLiked;
  final int? likeCount;
  final String paragraphId;
  final String? parentId;
  final int? replyCount;
  final int? reportCount;
  final String text;
  final String? updatedDate;
  final Profile? user;
  final String userId;

  Comment({
    required this.chapterId,
    this.children = const [],
    this.createdDate,
    this.isLiked,
    required this.id,
    this.isEnabled,
    this.likeCount,
    required this.paragraphId,
    this.parentId,
    this.replyCount,
    this.reportCount,
    required this.text,
    this.updatedDate,
    this.user,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    List<dynamic> childrenJsonList = json['children'] ?? [];
    final Profile? user =
        json['user'] == null ? null : Profile.fromJson(json['user']);

    return Comment(
      chapterId: json['chapter_id'],
      children: childrenJsonList.isEmpty
          ? []
          : childrenJsonList
              .map((childJson) => Comment.fromJson(childJson))
              .toList(),
      createdDate: json['created_date'],
      id: json['id'],
      isEnabled: json['is_enabled'],
      likeCount: json['like_count'],
      paragraphId: json['paragraph_id'],
      parentId: json['parent_id'],
      replyCount: json['reply_count'],
      reportCount: json['report_count'],
      text: json['text'],
      isLiked: json['is_liked'],
      updatedDate: json['updated_date'],
      user: user,
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'children': children?.map((child) => child.toJson()).toList(),
      'created_date': createdDate,
      'id': id,
      'is_enabled': isEnabled,
      'like_count': likeCount,
      'paragraph_id': paragraphId,
      'parent_id': parentId,
      'reply_count': replyCount,
      'report_count': reportCount,
      'is_liked': isLiked,
      'text': text,
      'updated_date': updatedDate,
      'user': user?.toJson(),
      'user_id': userId,
    };
  }
}
