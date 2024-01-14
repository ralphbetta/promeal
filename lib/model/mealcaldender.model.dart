class CalenderModel {
    int? id;
    String? breakfast;
    String? lunch;
    String? dinner;
    String? day;
    String? week;
    String? dayOfWeek;
    DateTime? date;
    DateTime? createdAt;

    CalenderModel({
        this.id,
        this.breakfast,
        this.lunch,
        this.dinner,
        this.day,
        this.week,
        this.dayOfWeek,
        this.date,
        this.createdAt,
    });

    factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
        id: json["id"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        dinner: json["dinner"],
        day: json["day"],
        week: json["week"],
        dayOfWeek: json["dayOfWeek"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner,
        "day": day,
        "week": week,
        "dayOfWeek": dayOfWeek,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
    };
}
