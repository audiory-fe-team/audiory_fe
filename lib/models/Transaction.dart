class Transaction {
  String? id;
  String? userId;
  String? productType;
  String? productId;
  String? productName;
  int? coinId;
  dynamic totalPrice; //int, double
  dynamic totalPriceAfterCommission; //int,double
  String? transactionType;
  String? transactionStatus;
  String? createdDate;
  String? updatedDate;

  Transaction(
      {this.id,
      this.userId,
      this.productType,
      this.productId,
      this.productName,
      this.coinId,
      this.totalPrice,
      this.totalPriceAfterCommission,
      this.transactionType,
      this.transactionStatus,
      this.createdDate,
      this.updatedDate});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productType = json['product_type'];
    productId = json['product_id'];
    productName = json['product_name'];
    coinId = json['coin_id'];
    totalPrice = json['total_price'];
    totalPriceAfterCommission = json['total_price_after_commission'];
    transactionType = json['transaction_type'];
    transactionStatus = json['transaction_status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_type'] = productType;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['coin_id'] = coinId;
    data['total_price'] = totalPrice;
    data['total_price_after_commission'] = totalPriceAfterCommission;
    data['transaction_type'] = transactionType;
    data['transaction_status'] = transactionStatus;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}
