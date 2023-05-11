import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/routers/app_pages.dart';
class CurrencyFormatter {
  CurrencyFormatter._();

  static String encoded({required String price}) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return value;
  }

  static String encodedDot({required String price}) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
    return value;
  }

  static String decoded({required String price}) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    return value;
  }

  static TimeOfDay minutesToTimeOfDay(int minutesPastMidnight) {
    int hours = minutesPastMidnight ~/ 60;
    int minutes = minutesPastMidnight % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }

  static int timeOfDayToMinutes(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    int minutes = timeOfDay.minute;
    int convertTime = hour * 60 + minutes;
    return convertTime;
  }
  static String formatTimeOfDay({required TimeOfDay timeOfDay}) {
    final localizations = MaterialLocalizations.of(
        AppPages.navigationKey.currentContext!);
    final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
    return formattedTimeOfDay;
  }

  static String formatDateToTimeOfDay({required DateTime timeOfDay}) {
    final localizations = MaterialLocalizations.of(
        AppPages.navigationKey.currentContext!);
    final formattedTimeOfDay = localizations.formatTimeOfDay(
        TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute));
    return formattedTimeOfDay;
  }
  static TimeOfDay? parseTimeOfDay(String? value) {
    if (value == null) {
      return null;
    }
    final format = DateFormat.Hm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(value));
  }

  static TimeOfDay fromString(String? time) {
    int hh = 0;
    if (time!.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24,
      // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }
}
