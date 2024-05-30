
import 'package:intl/intl.dart';

  String getFormatedTime(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
      final DateFormat formatter = DateFormat.jm();
      return formatter.format(dateTime);
  }
  
  String getFormatedDate(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
      return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String getTimeFromUtcDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm:ss.SSS z');
    return formatter.format(dateTime);
  }