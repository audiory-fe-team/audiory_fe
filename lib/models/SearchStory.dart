class SearchStory {
  final String id;
  final String? authorId;
  final String? tags;
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
  final int? coinCost;
  final int? authorEarningPercentage;
  final String? paywallEffectiveDate;
  final int? numFreeChapters;
  final int? reportCount;
  final int? voteCount;
  final int? readCount;
  final int? publishedCount;
  final String? createdDate;
  final String? updatedDate;
  final bool? isEnabled;
  final String? fullName;
  final String? avatarUrl;

  const SearchStory(
      {required this.id,
      this.authorId,
      this.tags,
      // this.category_ranking,
      this.categoryId,
      required this.title,
      this.description,
      this.coverUrl,
      this.isDraft,
      this.publishedCount,
      this.isMature,
      this.isCompleted,
      this.isCopyright,
      this.isPaywalled,
      this.coinCost,
      this.authorEarningPercentage,
      this.paywallEffectiveDate,
      this.numFreeChapters,
      this.reportCount,
      this.avatarUrl,
      this.fullName,
      this.readCount,
      this.createdDate,
      this.updatedDate,
      this.isEnabled,
      this.voteCount});

  factory SearchStory.fromJson(Map<String, dynamic> json) {
    return SearchStory(
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
      coinCost: json["coin_cost"],
      authorEarningPercentage: json["author_earning_percentage"],
      paywallEffectiveDate: json["paywall_effective_date"] ?? 'null',
      numFreeChapters: json["num_free_chapters"],
      reportCount: json["report_count"],
      voteCount: json["vote_count"],
      readCount: json["read_count"],
      createdDate: json["created_date"],
      updatedDate: json["updated_date"],
      isEnabled: json["is_enabled"],
      avatarUrl: json["avatar_url"],
      fullName: json["full_name"],
      tags: json['tags'],
      publishedCount: json['published_count'],
    );
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
        "coin_cost": coinCost,
        "author_earning_percentage": authorEarningPercentage,
        "paywall_effective_date": paywallEffectiveDate,
        "num_free_chapters": numFreeChapters,
        "report_count": reportCount,
        "vote_count": voteCount,
        "read_count": readCount,
        "full_name": fullName,
        "avatar_url": avatarUrl,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "is_enabled": isEnabled,
        "tags": tags,
        "published_count": publishedCount
      };
}
