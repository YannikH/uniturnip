import 'package:flutter/material.dart';

/// Parse date and time and return as single string.
String parseDateTime(DateTime date, TimeOfDay time) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');

  return '$day-$month-$year $hour:$minute';
}

String parseDate(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  return '$day-$month-$year';
}