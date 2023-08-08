class SignInBody {
  String username_or_email;
  String password;

  SignInBody({required this.username_or_email, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username_or_email'] = username_or_email;
    data['password'] = password;
    return data;
  }
}
