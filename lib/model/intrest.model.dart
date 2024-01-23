class IntrestModel {
    int? id;
    int? timetable;
    String? meal;
    String? mclass;
    DateTime? date;
    DateTime? createdAt;
    int? accountId;
    int? timetableId;
    Account? account;

    IntrestModel({
        this.id,
        this.timetable,
        this.meal,
        this.mclass,
        this.date,
        this.createdAt,
        this.accountId,
        this.timetableId,
        this.account,
    });

    factory IntrestModel.fromJson(Map<String, dynamic> json) => IntrestModel(
        id: json["id"],
        timetable: json["timetable"],
        meal: json["meal"],
        mclass: json["mclass"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        accountId: json["AccountId"],
        timetableId: json["TimetableId"],
        account: json["Account"] == null ? null : Account.fromJson(json["Account"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "timetable": timetable,
        "meal": meal,
        "mclass": mclass,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "AccountId": accountId,
        "TimetableId": timetableId,
        "Account": account?.toJson(),
    };
}

class Account {
    int? id;
    String? key;
    String? name;
    String? email;
    String? role;
    bool? approved;
    String? password;
    DateTime? createdAt;

    Account({
        this.id,
        this.key,
        this.name,
        this.email,
        this.role,
        this.approved,
        this.password,
        this.createdAt,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        approved: json["approved"],
        password: json["password"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "name": name,
        "email": email,
        "role": role,
        "approved": approved,
        "password": password,
        "createdAt": createdAt?.toIso8601String(),
    };
}
