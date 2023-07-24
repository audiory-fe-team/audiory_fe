class StoryServer {
  final String id;
  final String? author_id;
  final List<String>? tags;
  final List<int>? category_ranking;
  final String? category_id;
  final String title;
  final String? description;
  final String? cover_url;
  final bool? is_draft;
  final bool? is_mature;
  final bool? is_completed;
  final bool? is_copyright;
  final bool? is_paywalled;
  final bool? coin_cost;
  final int? author_earning_percentage;
  final int? paywall_effective_date;
  final int? num_free_chapters;
  final int? report_count;
  final int? explicit_percentage;
  final String? created_date;
  final String? updated_date;
  final String? is_enabled;

  StoryServer({
    required this.id,
    this.author_id,
    this.tags,
    this.category_ranking,
    this.category_id,
    required this.title,
    this.description,
    this.cover_url,
    this.is_draft,
    this.is_mature,
    this.is_completed,
    this.is_copyright,
    this.is_paywalled,
    this.coin_cost,
    this.author_earning_percentage,
    this.paywall_effective_date,
    this.num_free_chapters,
    this.report_count,
    this.explicit_percentage,
    this.created_date,
    this.updated_date,
    this.is_enabled,
  });
  factory StoryServer.fromJson(Map<String, dynamic> json) => StoryServer(
        id: json["id"],
        author_id: json["author_id"],
        tags: List<String>.from(json["tags"] ?? []),
        category_ranking: List<int>.from(json["category_ranking"] ?? []),
        category_id: json["category_id"],
        title: json["title"],
        description: json["description"],
        cover_url: json["cover_url"],
        is_draft: json["is_draft"],
        is_mature: json["is_mature"],
        is_completed: json["is_completed"],
        is_copyright: json["is_copyright"],
        is_paywalled: json["is_paywalled"],
        coin_cost: json["coin_cost"],
        author_earning_percentage: json["author_earning_percentage"],
        paywall_effective_date: json["paywall_effective_date"],
        num_free_chapters: json["num_free_chapters"],
        report_count: json["report_count"],
        explicit_percentage: json["explicit_percentage"],
        created_date: json["created_date"],
        updated_date: json["updated_date"],
        is_enabled: json["is_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": author_id,
        "tags": tags,
        "category_ranking": category_ranking,
        "category_id": category_id,
        "title": title,
        "description": description,
        "cover_url": cover_url,
        "is_draft": is_draft,
        "is_mature": is_mature,
        "is_completed": is_completed,
        "is_copyright": is_copyright,
        "is_paywalled": is_paywalled,
        "coin_cost": coin_cost,
        "author_earning_percentage": author_earning_percentage,
        "paywall_effective_date": paywall_effective_date,
        "num_free_chapters": num_free_chapters,
        "report_count": report_count,
        "explicit_percentage": explicit_percentage,
        "created_date": created_date,
        "updated_date": updated_date,
        "is_enabled": is_enabled,
      };
}
