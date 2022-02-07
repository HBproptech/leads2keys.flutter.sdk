import 'dart:convert';

import 'package:http/http.dart' as http;

String clientId = "flutter";
String clientSecret = "b076542a-13dd-4d7d-aed6-b4a741f6de8f";
final tokenEndpoint = Uri.parse('https://api.l2k.io/auth/token');

String server = 'https://api.l2k.io/';

class LK {
  void signIn(String url) async {
    if (url.contains('code')) {
      String codeAuth = url.substring(url.indexOf('=') + 1, url.indexOf('&'));
      String state = url.substring(url.lastIndexOf('=') + 1);
      http.Response response = await http.post(
          Uri.parse(
              "$tokenEndpoint?client_id=$clientId&code=$codeAuth&state=$state"),
          body: {
            'client_secret': clientSecret,
            'client_id': clientId,
            'grant_type': 'authorization_code',
            'code': codeAuth
          },
          headers: {
            'content_type': 'application/json'
          });
      final json = jsonDecode(response.body);
      String accessToken = json["access_token"];
      String refreshToken = json["refresh_token"];
      print(accessToken);
      print(refreshToken);
    }
  }
}
