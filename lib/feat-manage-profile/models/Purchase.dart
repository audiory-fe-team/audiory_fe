class Purchase {
  String? id;
  String? userId;
  String? coinPackId;
  int? paymentMethodId;
  int? totalPrice;
  int? totalPriceAfterPromotion;
  String? status;
  Null? coinPack;
  Null? paymentMethod;
  String? createdDate;
  String? updatedDate;

  Purchase(
      {this.id,
      this.userId,
      this.coinPackId,
      this.paymentMethodId,
      this.totalPrice,
      this.totalPriceAfterPromotion,
      this.status,
      this.coinPack,
      this.paymentMethod,
      this.createdDate,
      this.updatedDate});

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    coinPackId = json['coin_pack_id'];
    paymentMethodId = json['payment_method_id'];
    totalPrice = json['total_price'];
    totalPriceAfterPromotion = json['total_price_after_promotion'];
    status = json['status'];
    coinPack = json['coin_pack'];
    paymentMethod = json['payment_method'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['coin_pack_id'] = coinPackId;
    data['payment_method_id'] = paymentMethodId;
    data['total_price'] = totalPrice;
    data['total_price_after_promotion'] = totalPriceAfterPromotion;
    data['status'] = status;
    data['coin_pack'] = coinPack;
    data['payment_method'] = paymentMethod;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}
