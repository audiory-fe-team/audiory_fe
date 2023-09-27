import 'package:audiory_v0/models/Profile.dart';

class Comment {
  final String chapterId;
  // final List<dynamic> children;
  final String? createdDate;
  final String id;
  final bool? isEnabled;
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
    // required this.children,
    required this.createdDate,
    required this.id,
    required this.isEnabled,
    required this.likeCount,
    required this.paragraphId,
    required this.parentId,
    required this.replyCount,
    required this.reportCount,
    required this.text,
    required this.updatedDate,
    required this.user,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    // List<dynamic> childrenJsonList = json['children'] ?? [];

    // List<Comment> children = childrenJsonList
    //     .map((childJson) => Comment.fromJson(childJson))
    //     .toList();

    final Profile? user =
        json['user'] == null ? null : Profile.fromJson(json['user']);

    return Comment(
      chapterId: json['chapter_id'],
      // children: children,
      createdDate: json['created_date'] ?? 'null',
      id: json['id'],
      isEnabled: json['is_enabled'],
      likeCount: json['like_count'],
      paragraphId: json['paragraph_id'] ?? 'null',
      parentId: json['parent_id'] ?? 'null',
      replyCount: json['reply_count'],
      reportCount: json['report_count'],
      text: json['text'],
      updatedDate: json['updated_date'] ?? 'null',
      user: user,
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      // 'children': children.map((child) => child.toJson()).toList(),
      'created_date': createdDate,
      'id': id,
      'is_enabled': isEnabled,
      'like_count': likeCount,
      'paragraph_id': paragraphId,
      'parent_id': parentId,
      'reply_count': replyCount,
      'report_count': reportCount,
      'text': text,
      'updated_date': updatedDate,
      'user': user?.toJson(),
      'user_id': userId,
    };
  }
}
