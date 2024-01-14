class DateModel {
  String month;
  String day;
  String weekDay;
  String date;

  DateModel(
      {required this.weekDay,
      required this.day,
      required this.month,
      required this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['day'] = this.day;
    data['weekDay'] = this.weekDay;
    data['date'] = this.date;

    return data;
  }
}