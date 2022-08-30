import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/utils/time_utils.dart';

// void errorToast({
//   required String? code,
//   required String? message,
// }) {
//   Fluttertoast.showToast(
//     msg: 'Error Code: $code\nError Message: $message',
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: AppColors.white.withOpacity(0.4),
//     textColor: AppColors.black,
//     fontSize: 16.0,
//   );
// }

String getDayAndMonth(int? timestamp) {
  if (timestamp != null) {
    DateTime date = getDate(timestamp);
    return date.day.toString() + ' ' + getMonth(date);
  } else {
    return '';
  }
}

String getMonth(DateTime date) {
  switch (date.month) {
    case 1:
      return Constants.jan;
    case 2:
      return Constants.feb;
    case 3:
      return Constants.mar;
    case 4:
      return Constants.apr;
    case 5:
      return Constants.may;
    case 6:
      return Constants.jun;
    case 7:
      return Constants.jul;
    case 8:
      return Constants.aug;
    case 9:
      return Constants.sept;
    case 10:
      return Constants.oct;
    case 11:
      return Constants.nov;
    case 12:
      return Constants.dec;
    default:
      return '';
  }
}

String kelvinToCelsius(double? kelvin) {
  if (kelvin == null) {
    return Constants.notSpecified;
  } else {
    return (kelvin - 273.15).toStringAsFixed(1);
  }
}

String getWeatherImage(String? icon) {
  String res = '';
  String imgUrl = 'http://openweathermap.org/img/w/';
  String png = '.png';
  if (icon != null) {
    if (icon.isNotEmpty) {
      res = imgUrl + icon + png;
    }
  }
  return res;
}

String getClearName(String? firstName, String? lastName, {comma = false}) {
  return (firstName ?? '') +
      (firstName == null
          ? ''
          : firstName.isEmpty
              ? ''
              : comma
                  ? lastName == null
                      ? ''
                      : lastName.isEmpty
                          ? ''
                          : ', '
                  : ' ') +
      (lastName ?? '');
}

double? doubleParser(dynamic data) {
  try {
    final double? doubleResult = double.tryParse(data.toString());
    if (doubleResult != null) {
      return doubleResult;
    } else {
      final int? intResult = int.tryParse(data.toString());
      if (intResult != null) {
        return intResult.toDouble();
      } else {
        return null;
      }
    }
  } catch (_) {
    return null;
  }
}

Future<void> futureDelayed({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
