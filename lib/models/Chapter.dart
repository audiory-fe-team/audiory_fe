class Chapter {
  final int id;
  final String name;
  final int viewNum;
  final int voteNum;
  final int commentNum;
  final List<String> content;

  const Chapter({
    required this.id,
    required this.name,
    required this.viewNum,
    required this.voteNum,
    required this.commentNum,
    this.content = const [""],
  });
}
