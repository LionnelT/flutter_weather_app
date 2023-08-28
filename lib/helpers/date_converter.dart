// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

// This class is a DateConverter that converts a DateTime object to a day of the week string.
class DateConverter {
  static String getDayOfTheWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
