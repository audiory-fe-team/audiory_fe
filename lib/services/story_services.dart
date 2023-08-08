import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Story extends ChangeNotifier {
  String baseURL = "http://34.101.77.146:3500/api";

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String fullname,
  }) async {
    var url = Uri.parse(baseURL + '/users');

    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response = await http.get(url, headers: header);
      print('res');
      print(response.body);
      // if (response.statusCode == 200) {
      //   isBack = true;
      // }
    } on Exception catch (err) {}
  }
}
