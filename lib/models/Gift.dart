class Gift {
  String name;
  String? imgUrl;
  int price;

  Gift({
    required this.name,
    required this.imgUrl,
    required this.price,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      name: json['name'],
      imgUrl: json['img_url'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
    };
  }
}
