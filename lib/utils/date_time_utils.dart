import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static bool isSameDate(DateTime current, DateTime other) {
    return current.year == other.year &&
        current.month == other.month &&
        current.day == other.day;
  }

  static bool isWithinDays(DateTime? a, DateTime? b, DateTime? c) {
    if (a == null || b == null || c == null) {
      return false;
    }
    return getDate(a).millisecondsSinceEpoch <=
        getDate(c).millisecondsSinceEpoch &&
        getDate(b).millisecondsSinceEpoch >= getDate(c).millisecondsSinceEpoch;
  }

  static DateTime getDate(DateTime current) {
    return DateTime(current.year, current.month, current.day);
  }

  static DateTime getDateTime(DateTime current) {
    return DateTime(current.year, current.month, current.day, current.hour,
        current.minute, current.second);
  }

  static TimeOfDay getTimeOfDay(TimeOfDay current) {
    return TimeOfDay(hour: current.hour, minute: current.minute);
  }

  static DateTime? getCurrentDate(DateTime? current) {
    if (current == null) return null;
    return DateTime(current.year, current.month, current.day);
  }

  static String format(DateTime dateTime,
      {String formatString = "dd/MM/yyyy"}) {
    return DateFormat(formatString).format(dateTime);
  }

  static String formatHistoryOrder(DateTime dateTime,
      {String formatString = "dd/MM/yyyy HH:mm:ss"}) {
    return DateFormat(formatString).format(dateTime);
  }

  static String formatDay(DateTime dateTime, {String formatString = "dd"}) {
    return DateFormat(formatString).format(dateTime);
  }

  static String formatMonth(DateTime dateTime, {String formatString = "MM"}) {
    return DateFormat(formatString).format(dateTime);
  }

  static String formatYear(DateTime dateTime, {String formatString = "yyyy"}) {
    return DateFormat(formatString).format(dateTime);
  }

  static DateTime? parse(String? dateTimeString) {
    if (dateTimeString != null) {
      return DateTime.parse(dateTimeString);
    }
    return null;
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static String dateToString(DateTime date) {
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  static String dateToStringOrderMonth(DateTime date) {
    return "${date.year}/${_twoDigits(date.month)}";
  }
}
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}