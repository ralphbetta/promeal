class AccountModel {
  int? id;
  String? key;
  String? name;
  String? email;
  String? role;
  int? side;
  bool? approved;

  AccountModel({this.id, this.key, this.name, this.email, this.role, this.side, this.approved});

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        side: json["side"],
        approved: json["approved"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "name": name,
        "email": email,
        "role": role,
        "side": side,
        "approved": approved,
      };
}
