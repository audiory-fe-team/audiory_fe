import 'package:audiory_v0/models/AuthorStory.dart';

import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Tag.dart';

class Story {
  final String id;
  final String? authorId;
  final List<Tag>? tags;
  // final List<int>? category_ranking;
  final String? categoryId;
  final String title;
  final String? description;
  final String? coverUrl;
  final bool? isDraft;
  final bool? isMature;
  final bool? isCompleted;
  final bool? isCopyright;
  final bool? isPaywalled;
  final int? chapterPrice;
  final int? coinCost;
  final int? authorEarningPercentage;
  final String? paywallEffectiveDate;
  final int? numFreeChapters;
  final int? publishedCount;
  final int? draftCount;
  final int? reportCount;
  final int? voteCount;
  final int? totalVote;
  final int? totalRead;
  final int? readCount;
  final int? explicitPercentage;
  final String? createdDate;
  final String? updatedDate;
  final bool? isEnabled;
  final List<Chapter>? chapters;
  final AuthorStory? author;

  const Story(
      {required this.id,
      this.authorId,
      this.tags,
      // this.category_ranking,
      this.categoryId,
      required this.title,
      this.description,
      this.coverUrl,
      this.isDraft,
      this.isMature,
      this.isCompleted,
      this.isCopyright,
      this.isPaywalled,
      this.chapterPrice,
      this.coinCost,
      this.authorEarningPercentage,
      this.paywallEffectiveDate,
      this.numFreeChapters,
      this.reportCount,
      this.voteCount,
      this.totalRead,
      this.totalVote,
      this.draftCount,
      this.publishedCount,
      this.readCount,
      this.explicitPercentage,
      this.createdDate,
      this.updatedDate,
      this.isEnabled,
      this.chapters,
      this.author});

  factory Story.fromJson(Map<String, dynamic> json) {
    List<dynamic> chapterJsonList = json['chapters'] ?? [];
    List<Chapter> chapters = chapterJsonList
        .map((chapterJson) => Chapter.fromJson(chapterJson))
        .toList();
    List<dynamic> tagsJsonList = json['tags'] ?? [];
    List<Tag> tags = tagsJsonList.map((tag) => Tag.fromJson(tag)).toList();
    final AuthorStory? author =
        json['author'] == null ? null : AuthorStory.fromJson(json['author']);

    return Story(
        id: json["id"],
        authorId: json["author_id"] ?? 'null',
        categoryId: json["category_id"] ?? 'null',
        title: json["title"],
        description: json["description"] ?? 'null',
        coverUrl: json["cover_url"] ?? 'null',
        isDraft: json["is_draft"],
        isMature: json["is_mature"],
        isCompleted: json["is_completed"],
        isCopyright: json["is_copyright"],
        isPaywalled: json["is_paywalled"],
        chapterPrice: json["chapter_price"],
        coinCost: json["coin_cost"],
        authorEarningPercentage: json["author_earning_percentage"],
        paywallEffectiveDate: json["paywall_effective_date"] ?? 'null',
        numFreeChapters: json["num_free_chapters"],
        reportCount: json["report_count"],
        totalVote: json["total_vote"],
        voteCount: json["vote_count"],
        totalRead: json["total_read"],
        readCount: json["read_count"],
        draftCount: json["draft_count"],
        publishedCount: json["published_count"],
        explicitPercentage: json["explicit_percentage"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
        isEnabled: json["is_enabled"],
        chapters: chapters,
        tags: tags,
        author: author);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": authorId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "cover_url": coverUrl,
        "is_draft": isDraft,
        "is_mature": isMature,
        "is_completed": isCompleted,
        "is_copyright": isCopyright,
        "is_paywalled": isPaywalled,
        "chapter_price": chapterPrice,
        "coin_cost": coinCost,
        "author_earning_percentage": authorEarningPercentage,
        "paywall_effective_date": paywallEffectiveDate,
        "num_free_chapters": numFreeChapters,
        "report_count": reportCount,
        "vote_count": voteCount,
        "read_count": readCount,
        "total_read": totalRead,
        "total_vote": totalVote,
        "published_count": publishedCount,
        "draft_count": draftCount,
        "explicit_percentage": explicitPercentage,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "is_enabled": isEnabled,
        "chapters": chapters?.map((chapter) => chapter.toJson()).toList(),
        "tags": tags?.map((tag) => tag.toJson()).toList(),
        "author": author?.toJson(),
      };
}
