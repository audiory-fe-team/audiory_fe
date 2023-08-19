class Tag {
  String? createdDate;
  String id;
  bool? isEnabled;
  String name;
  String? updatedDate;
  int? worksTotal;

  Tag({
    this.createdDate,
    required this.id,
    this.isEnabled,
    required this.name,
    this.updatedDate,
    this.worksTotal,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      createdDate: json['created_date'],
      id: json['id'],
      isEnabled: json['is_enabled'],
      name: json['name'],
      updatedDate: json['updated_date'],
      worksTotal: json['works_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_date': createdDate,
      'id': id,
      'is_enabled': isEnabled,
      'name': name,
      'updated_date': updatedDate,
      'works_total': worksTotal,
    };
  }
}
