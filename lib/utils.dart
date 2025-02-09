extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }

  DateTime nextWeek(int day) {
    return DateTime(
      year,
      month,
      day + (day == weekday ? 7 : (day - weekday) % DateTime.daysPerWeek),
    );
  }
}
