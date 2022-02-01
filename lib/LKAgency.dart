class LKAgency {
  String id;
  String name;
  String email;
  String address;

  LKAgency(
      {required this.id,
      required this.name,
      required this.email,
      required this.address});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "email": email, "address": address};

  static LKAgency fromJson(Map<String, dynamic> json) {
    return LKAgency(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"]);
  }
}
