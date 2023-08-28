// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class DateConverter {
  static String getDayOfTheWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
