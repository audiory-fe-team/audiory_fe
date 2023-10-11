import 'package:audiory_v0/models/Coin.dart';

class Wallet {
  String? id;
  String? userId;
  int? coinId;
  dynamic balance;
  Coin? coin;

  Wallet({this.id, this.userId, this.coinId, this.balance, this.coin});

  Wallet.fromJson(Map<String, dynamic> json) {
    dynamic jsonCoin = json['coin'];
    print('CAST COIN');
    print('${Coin.fromJson(jsonCoin)}');

    Coin coin = Coin.fromJson(jsonCoin);
    id = json['id'];
    userId = json['user_id'];
    coinId = json['coin_id'];
    balance = json['balance'];
    coin = coin;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['coin_id'] = coinId;
    data['balance'] = balance;
    if (coin != null) {
      data['coin'] = coin!.toJson();
    }
    return data;
  }
}
