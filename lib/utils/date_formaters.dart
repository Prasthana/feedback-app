import 'package:flutter/material.dart';
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

String getFormatedDateConvertion(String dateTimeString, String outputFormate) {
  DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
  return DateFormat(outputFormate).format(dateTime);
}

String getTimeFromUtcDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('HH:mm:ss.SSS z');
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
