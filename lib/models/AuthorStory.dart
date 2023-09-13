class AuthorStory {
  final String id;
  final String? fullName;
  final String? sex;
  final String? avatarUrl;
  final String? registrationTokens;
  final String? roleId;

  AuthorStory(
      {required this.id,
      this.fullName,
      this.sex,
      this.avatarUrl,
      this.registrationTokens,
      this.roleId});

  factory AuthorStory.fromJson(Map<String, dynamic> json) {
    return AuthorStory(
      avatarUrl: json['avatar_url'],
      fullName: json['full_name'],
      id: json['id'],
      sex: json['sex'],
      registrationTokens: json['registration_tokens'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar_url': avatarUrl,
      'full_name': fullName,
      'id': id,
      'sex': sex,
      'registration_tokens': registrationTokens,
      'role_id': roleId,
    };
  }
}
