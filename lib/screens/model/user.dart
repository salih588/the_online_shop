import 'dart:convert';

import 'package:http/http.dart' as http;

class User{

  final String username;
  final String password;

  User(this.username, this.password);

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };

  Future<String> checkLogin() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https('fakestoreapi.com','/auth/login'),
          body: toJson());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return "Success";
      // var uri = Uri.parse(decodedResponse['uri'] as String);
      // print(decodedResponse);
    } catch (e) {
    client.close();
    return "Failure";
    }
  }
}