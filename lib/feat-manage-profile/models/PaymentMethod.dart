class PaymentMethod {
  int? id;
  String? name;
  String? description;
  String? createdDate;
  String? updatedDate;

  PaymentMethod(
      {this.id,
      this.name,
      this.description,
      this.createdDate,
      this.updatedDate});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}
