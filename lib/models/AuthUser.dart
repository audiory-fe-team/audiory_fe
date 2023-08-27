class UserServer {
  String? id;
  bool? isEnabled;
  String? fullName;
  String? email;
  String? avatarUrl;
  bool? isOnline;
  String? createdDate;
  String? updatedDate;

  UserServer(
      {this.id,
      this.isEnabled,
      this.fullName,
      this.email,
      this.avatarUrl,
      this.isOnline,
      this.createdDate,
      this.updatedDate});

  UserServer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isEnabled = json['is_enabled'];
    fullName = json['full_name'];
    email = json['email'];
    avatarUrl = json['avatar_url'];
    isOnline = json['is_online'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_enabled'] = this.isEnabled;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['avatar_url'] = this.avatarUrl;
    data['is_online'] = this.isOnline;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}
