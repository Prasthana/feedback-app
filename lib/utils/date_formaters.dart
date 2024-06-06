import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String hoursMinutes12 = "hh:mm a";
const String hoursMinutes24 = "HH:mm";
const String dateMonthYear = "dd-MM-yyyy";
const String yearMonthDate = "yyyy-MM-dd";

String getFormatedDateConvertion(String dateTimeString, String outputFormate) {
  DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
  return DateFormat(outputFormate).format(dateTime);
}

String getTimeFromUtcDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat(hoursMinutes24);
  return formatter.format(dateTime);
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final DateFormat formatter = DateFormat.jm();
  return formatter.format(DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, timeOfDay.hour, timeOfDay.minute));
}

TimeOfDay addOneHour(TimeOfDay timeOfDay) {
  final newHour = (timeOfDay.hour + 1) % 24;
  final newMinute = timeOfDay.minute;
  return TimeOfDay(hour: newHour, minute: newMinute);
}

DateTime toUtcDateTime(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final utcDateTime = DateTime.utc(
      now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return utcDateTime;
}

extension DateConverssionExtension on String {
  String utcToLocalDate(String outputFormate) {
    DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat(outputFormate).format(dateTime);
  }

  DateTime utcDateObj(String inputDateformat) {
    final DateFormat dateFormatter = DateFormat(inputDateformat);
    DateTime dateObj = dateFormatter.parse(this);
    var utcDate = dateObj.toUtc();
    return utcDate;
  }
}
