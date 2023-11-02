class CoinPack {
  String? id;
  int? coinId;
  String? name;
  int? coinAmount;
  String? imageUrl;
  int? price;
  int? priceAfterPromotion;
  String? createdDate;
  String? updatedDate;

  CoinPack(
      {this.id,
      this.coinId,
      this.name,
      this.coinAmount,
      this.imageUrl,
      this.price = 0,
      this.priceAfterPromotion = 0,
      this.createdDate,
      this.updatedDate});

  CoinPack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coinId = json['coin_id'];
    name = json['name'];
    coinAmount = json['coin_amount'];
    imageUrl = json['image_url'];
    price = json['price'];
    priceAfterPromotion = json['price_after_promotion'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coin_id'] = this.coinId;
    data['name'] = this.name;
    data['coin_amount'] = this.coinAmount;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['price_after_promotion'] = this.priceAfterPromotion;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}
