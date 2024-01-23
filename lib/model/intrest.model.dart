class IntrestModel {
    int? id;
    int? timetable;
    String? meal;
    DateTime? date;
    DateTime? createdAt;
    int? accountId;
    int? timetableId;
    String? mclass;

    IntrestModel({
        this.id,
        this.timetable,
        this.meal,
        this.date,
        this.createdAt,
        this.accountId,
        this.timetableId,
        this.mclass,
    });

    factory IntrestModel.fromJson(Map<String, dynamic> json) => IntrestModel(
        id: json["id"],
        timetable: json["timetable"],
        meal: json["meal"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        accountId: json["AccountId"],
        timetableId: json["TimetableId"],
        mclass: json['mclass'],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "timetable": timetable,
        "meal": meal,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "AccountId": accountId,
        "TimetableId": timetableId,
        "mclass": mclass
    };
}