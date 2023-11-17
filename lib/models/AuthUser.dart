import 'package:audiory_v0/models/wallet/wallet_model.dart';

class AuthUser {
  String? id;
  bool? isEnabled;
  String? fullName;
  String? username;
  String? email;
  String? avatarUrl;
  String? backgroundUrl;
  bool? isOnline;
  String? description;
  String? facebookUrl;
  String? createdDate;
  String? updatedDate;
  int? numOfFollowers;
  int? numOfFollowing;
  int? levelId;
  int? authorLevelId;
  List<Wallet>? wallets;

  AuthUser(
      {this.id,
      this.isEnabled = true,
      this.fullName,
      this.username,
      this.email,
      this.avatarUrl,
      this.backgroundUrl,
      this.isOnline,
      this.description,
      this.facebookUrl,
      this.createdDate,
      this.updatedDate,
      this.numOfFollowers = 0,
      this.numOfFollowing = 0,
      this.levelId = 1,
      this.authorLevelId = 1,
      this.wallets});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    List<dynamic> walletsJsonList = json['wallets'] ?? [];
    List<Wallet> wallets =
        walletsJsonList.map((wallet) => Wallet.fromJson(wallet)).toList();

    return AuthUser(
      id: json['id'] ?? 0,
      isEnabled: json['is_enabled'],
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      backgroundUrl: json['background_url'],
      facebookUrl: json['facebook_url'],
      isOnline: json['is_online'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      numOfFollowers: json['number_of_followers'],
      numOfFollowing: json['number_of_following'],
      levelId: json['level_id'],
      authorLevelId: json['author_level_id'],
      wallets: wallets,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_enabled'] = isEnabled;
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['avatar_url'] = avatarUrl;
    data['background_url'] = backgroundUrl;
    data['facebook_url'] = facebookUrl;
    data['is_online'] = isOnline;
    data['number_of_followers'] = numOfFollowers;
    data['number_of_following'] = numOfFollowing;
    data['level_id'] = levelId;
    data['author_level_id'] = authorLevelId;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['wallets'] = wallets;
    return data;
  }
}
