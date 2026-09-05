import 'package:intl/intl.dart';

class FormatDate {
  static String formatDateByDayMonthYear(DateTime date){
    return DateFormat("d MMM y").format(date);
  }
}