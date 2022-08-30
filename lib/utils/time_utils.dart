import 'dart:developer';

DateTime getDate(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

// String getDayAndMonth(int? timestamp) {
//   if (timestamp != null) {
//     DateTime date = getDate(timestamp);
//     return date.day.toString() + ' ' + getMonth(date);
//   } else {
//     return '';
//   }
// }

String getTimeHour(int? timestamp) {
  String time = '';
  if (timestamp != null) {
    try {
      DateTime date = getDate(timestamp);
      if (timestamp != 0) {
        time = date.hour.toString() + ':' + (
          date.minute.toString().length == 1 ? '0' + date.minute.toString() : date.minute.toString()
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
  return time;
}

