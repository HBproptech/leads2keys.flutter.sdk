import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leads2keys_api/LKAccount.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

String clientId = "flutter";
String clientSecret = "b076542a-13dd-4d7d-aed6-b4a741f6de8f";
final authorizationEndpoint = Uri.parse('http://api.l2k.io/auth/');
final tokenEndpoint = Uri.parse('http://api.l2k.io/auth/token');

String server = 'https://api.l2k.io/';
oauth2.Client? client;

Future<String?> getToken() async {
  try {} catch (error) {
    print(error);
  }
}

Future<http.Response> getWithQuery(String api, String query) async {
  return await client!.get(Uri.parse('$server$api?$query'));
}

Future<LKAccount?> getAccount(Map<String, dynamic> json) async {
  http.Response response =
      await client!.get(Uri.parse("http://api.l2k.io/auth"));
  if (response.statusCode == 200)
    return LKAccount.fromJson(jsonDecode(response.body));
  else {
    print(response.body);
    return null;
  }
}

Future<oauth2.Client?> createClient() async {
  try {
    client = await oauth2.clientCredentialsGrant(
        tokenEndpoint, clientId, clientSecret,
        basicAuth: false);
    return client;
  } catch (error) {
    print("Erreur : $error");
  }
}

class LK {
  Future<LKAccount?> signIn(Map<String, dynamic> json) async {
    return await getAccount(json);
  }
}
