class Coin {
  int? id;
  String? name;
  dynamic value;
  String? imageUrl;
  String? createdDate;
  String? updatedDate;

  Coin(
      {this.id,
      this.name,
      this.value,
      this.imageUrl,
      this.createdDate,
      this.updatedDate});

  Coin.fromJson(Map<String, dynamic> json) {
    print('CAST COIN VALUE');
    print('${json['value']}');
    id = json['id'];
    name = json['name'];
    value = json['value'];
    imageUrl = json['image_url'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['image_url'] = imageUrl;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}
