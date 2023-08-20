class Category {
  final String id;
  final String? name;
  final String? imageUrl;
  final String? createdDate;
  final String? updatedDate;
  final bool? isEnabled;
  // final List<dynamic>? stories;
  // final dynamic categoryRanking;

  Category({
    required this.id,
    this.name,
    this.imageUrl,
    this.createdDate,
    this.updatedDate,
    this.isEnabled,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      isEnabled: json['is_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'created_date': createdDate,
      'updated_date': updatedDate,
      'is_enabled': isEnabled,
    };
  }
}
