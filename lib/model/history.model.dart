class HistoryModel {
    int? id;
    String? breakfast;
    String? lunch;
    String? dinner;
    String? day;
    String? dayOfWeek;
    DateTime? date;
    DateTime? createdAt;
    List<Review>? reviews;

    HistoryModel({
        this.id,
        this.breakfast,
        this.lunch,
        this.dinner,
        this.day,
        this.dayOfWeek,
        this.date,
        this.createdAt,
        this.reviews,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        dinner: json["dinner"],
        day: json["day"],
        dayOfWeek: json["dayOfWeek"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        reviews: json["Reviews"] == null ? [] : List<Review>.from(json["Reviews"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner,
        "day": day,
        "dayOfWeek": dayOfWeek,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "Reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Review {
    int? id;
    String? sender;
    String? name;
    String? review;
    int? timetable;
    int? rating;
    String? mclass;
    String? meal;
    DateTime? createdAt;
    int? accountId;
    int? timetableId;

    Review({
        this.id,
        this.sender,
        this.name,
        this.review,
        this.timetable,
        this.rating,
        this.mclass,
        this.meal,
        this.createdAt,
        this.accountId,
        this.timetableId,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        sender: json["sender"],
        name: json["name"],
        review: json["review"],
        timetable: json["timetable"],
        rating: json["rating"],
        mclass: json["mclass"],
        meal: json["meal"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        accountId: json["AccountId"],
        timetableId: json["TimetableId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "name": name,
        "review": review,
        "timetable": timetable,
        "rating": rating,
        "mclass": mclass,
        "meal": meal,
        "createdAt": createdAt?.toIso8601String(),
        "AccountId": accountId,
        "TimetableId": timetableId,
    };
}
