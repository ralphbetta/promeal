class ScheduleModel {
    List<TCalender>? presentCalender;
    List<TCalender>? nextCalender;
    List<Schedule>? schedules;

    ScheduleModel({
        this.presentCalender,
        this.nextCalender,
        this.schedules,
    });

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        presentCalender: json["presentCalender"] == null ? [] : List<TCalender>.from(json["presentCalender"]!.map((x) => TCalender.fromJson(x))),
        nextCalender: json["nextCalender"] == null ? [] : List<TCalender>.from(json["nextCalender"]!.map((x) => TCalender.fromJson(x))),
        schedules: json["schedules"] == null ? [] : List<Schedule>.from(json["schedules"]!.map((x) => Schedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "presentCalender": presentCalender == null ? [] : List<dynamic>.from(presentCalender!.map((x) => x.toJson())),
        "nextCalender": nextCalender == null ? [] : List<dynamic>.from(nextCalender!.map((x) => x.toJson())),
        "schedules": schedules == null ? [] : List<dynamic>.from(schedules!.map((x) => x.toJson())),
    };
}

class TCalender {
    int? index;
    DateTime? date;
    String? day;

    TCalender({
        this.index,
        this.date,
        this.day,
    });

    factory TCalender.fromJson(Map<String, dynamic> json) => TCalender(
        index: json["index"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "date": date?.toIso8601String(),
        "day": day,
    };
}

class Schedule {
    int? id;
    String? breakfast;
    String? lunch;
    String? dinner;
    String? day;
    String? dayOfWeek;
    DateTime? date;
    DateTime? createdAt;

    Schedule({
        this.id,
        this.breakfast,
        this.lunch,
        this.dinner,
        this.day,
        this.dayOfWeek,
        this.date,
        this.createdAt,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        dinner: json["dinner"],
        day: json["day"],
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
        "dayOfWeek": dayOfWeek,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
    };
}
