import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  DateTime increasedDate = date.add(Duration(days: 1));
  String formattedDate = DateFormat("EEEE d'th' MMM, y").format(increasedDate);
  return formattedDate;
}

String formatDateDot(DateTime date) {
  DateTime increasedDate = date.add(Duration(days: 1));
  String formattedDate = DateFormat("d.MM.yy").format(increasedDate);
  return formattedDate;
}
