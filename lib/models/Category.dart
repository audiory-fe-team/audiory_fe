class Category {
  dynamic? id;
  String? name;
  String? imageUrl;
  String? createdDate;
  String? updatedDate;
  bool? isEnabled;
  List<dynamic>? stories;
  int? categoryRanking;

  //mock
  String? coverUrl;
  String? title;

  Category(
      {this.id,
      this.name,
      this.imageUrl,
      this.createdDate,
      this.updatedDate,
      this.isEnabled,
      this.stories,
      this.categoryRanking,
      //mock data
      this.coverUrl,
      this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    isEnabled = json['is_enabled'];
    stories = json['stories'];
    categoryRanking = json['category_ranking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['is_enabled'] = this.isEnabled;
    data['stories'] = this.stories;
    data['category_ranking'] = this.categoryRanking;
    return data;
  }
}
