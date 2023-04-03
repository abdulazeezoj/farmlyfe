import 'package:intl/intl.dart';

// function to convert DateTime to date like March 1, 2021
String? dateTimeToDate(DateTime? dateTime) {
  String date;

  // format the time to March 1, 2021
  date = DateFormat('MMMM d, yyyy').format(dateTime!);

  return date;
}

// function to convert DateTime to time like 11:00 PM
String? dateTimeToTime(DateTime? dateTime) {
  String time;

  // format the time to 11:00 PM
  time = DateFormat('h:mm a').format(dateTime!);

  return time;
}

// function to convert DateTime to date and time like Mar 1
String? dateTimeToDateShort(DateTime? dateTime) {
  String dateTimeString;

  // format the time to Mar 1
  dateTimeString = DateFormat('MMM d').format(dateTime!);

  return dateTimeString;
}
