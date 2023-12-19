class AdminFoodModel {
    int? id;
    int? owner;
    String? claimerKey;
    String? meal;
    bool? claimed;
    bool? forfeited;
    DateTime? createdAt;
    ActingUser? actingUser;
    int? side;

    AdminFoodModel({
        this.id,
        this.owner,
        this.claimerKey,
        this.meal,
        this.claimed,
        this.forfeited,
        this.createdAt,
        this.actingUser,
        this.side
    });

    factory AdminFoodModel.fromJson(Map<String, dynamic> json) => AdminFoodModel(
        id: json["id"],
        owner: json["owner"],
        claimerKey: json["claimerKey"],
        meal: json["meal"],
        claimed: json["claimed"],
        forfeited: json["forfeited"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        actingUser: json["actingUser"] == null ? null : ActingUser.fromJson(json["actingUser"]),
        side: json["side"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner,
        "claimerKey": claimerKey,
        "meal": meal,
        "claimed": claimed,
        "forfeited": forfeited,
        "createdAt": createdAt?.toIso8601String(),
        "actingUser": actingUser?.toJson(),
        "side": side,
    };
}

class ActingUser {
    int? id;
    String? key;
    String? name;
    String? email;
    String? role;
    String? password;
    DateTime? createdAt;

    ActingUser({
        this.id,
        this.key,
        this.name,
        this.email,
        this.role,
        this.password,
        this.createdAt,
    });

    factory ActingUser.fromJson(Map<String, dynamic> json) => ActingUser(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        password: json["password"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "name": name,
        "email": email,
        "role": role,
        "password": password,
        "createdAt": createdAt?.toIso8601String(),
    };
}
