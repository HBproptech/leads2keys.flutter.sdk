import 'package:leads2keys_api/LKMandate.dart';

import 'LKAgency.dart';
import 'LKUser.dart';

class LKAccount {
  String id;
  String token;
  String refreshToken;
  LKUser user;
  LKAgency agency;
  List<LKMandate>? mandates;

  LKAccount(
      {required this.id,
      required this.token,
      required this.refreshToken,
      required this.user,
      required this.agency,
      this.mandates});

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refreshToken": refreshToken,
        "user": user,
        "agency": agency
      };

  static LKAccount fromJson(Map<String, dynamic> json) {
    return LKAccount(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        user: LKUser.fromJson(json["user"]),
        agency: LKAgency.fromJson(json["agency"]),
        mandates: List<LKMandate>.from(
            List.from(json['mandats']).map((e) => LKMandate.fromJson(e))));
  }

  Future<List<LKMandate>?> getMandates(String query) async {
    /* final response = await getWithQuery("mandates", query);
    if (response.statusCode == 200)
      return List<LKMandate>.from(
          List.from(jsonDecode(response.body)["mandats"])
              .map((e) => LKMandate.fromJson(e))); */
  }
}
