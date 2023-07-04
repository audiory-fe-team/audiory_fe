class Story {
  final int id;
  final String? authorName;
  final List<String>? tags;
  final int? categoryId;
  final String title;
  final String? description;
  final String? coverUrl;
  final bool? isDraft;
  final bool? isMature;
  final int? numChapter;
  final int? readCount;
  final int? voteCount;

  const Story({
    required this.id,
    this.authorName,
    this.tags,
    this.categoryId,
    required this.title,
    this.description,
    required this.coverUrl,
    this.isDraft,
    this.isMature,
    this.numChapter,
    this.readCount,
    this.voteCount,
  });
}
