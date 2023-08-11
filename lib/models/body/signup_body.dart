class SignUpBody {
  String email;
  String username;
  String full_name;
  String password;

  SignUpBody({
    required this.email,
    required this.username,
    required this.full_name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['full_name'] = full_name;
    data['password'] = password;
    return data;
  }
}
