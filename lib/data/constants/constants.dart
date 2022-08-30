// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  static const URL = "http://dev.sendapp.com.au/";
  static const baseUrl = 'newsapi.org';
  static const apiKey = '0efcfe703cb44a2c822f915c24bb5aea';
  static const contry = 'in';
  static const String API_KEY = "fcbad9afa99d4e8db6828f4812c59ea4";

  static const No_INTERNET_ISSUES = "No Internet Connection";
  static const STATUS_No_INTERNET_ISSUES = "INTERNET_ERROR";

  static const CONNECTION_TIME_OUT =
      'Connection timeout please retry after some time';
  static const STATUS_CONNECTION_TIME_OUT = 'CONNECTION_TIMEOUT';

  static const PROBLEM_ISSUES = "Currently we are facing some issues";
  static const STATUS_PROBLEM_ISSUES = "INTERNAL_ISSUES";

  static const SOMETHING_WENT_WRONG = "Some thing went wrong";
  static const STATUS_SOMETHING_WENT_WRONG = "WENT_WRONG";
  static const String TOP_HEADLINES_URL =
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$API_KEY';

  static const String WORLD_NEWS_URL =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$API_KEY';
  static const MaterialColor green = MaterialColor(0xFF3AB472, greenMaterial);
  static const String notSpecified = 'not_specified';
  static const String hourlyWeather = 'hourly_weather';
  static const String weatherByDay = 'weather_by_day';

  static const Map<int, Color> greenMaterial = <int, Color>{
    50: Color.fromRGBO(58, 180, 114, .1),
    100: Color.fromRGBO(58, 180, 114, .2),
    200: Color.fromRGBO(58, 180, 114, .3),
    300: Color.fromRGBO(58, 180, 114, .4),
    400: Color.fromRGBO(58, 180, 114, .5),
    500: Color.fromRGBO(58, 180, 114, .6),
    600: Color.fromRGBO(58, 180, 114, .7),
    700: Color.fromRGBO(58, 180, 114, .8),
    800: Color.fromRGBO(58, 180, 114, .9),
    900: Color.fromRGBO(58, 180, 114, 1),
  };

  // Months
  static const String monthOb = 'month.';
  static const String jan = '${Constants.monthOb}jan';
  static const String feb = '${Constants.monthOb}feb';
  static const String mar = '${Constants.monthOb}mar';
  static const String apr = '${Constants.monthOb}apr';
  static const String may = '${Constants.monthOb}may';
  static const String jun = '${Constants.monthOb}jun';
  static const String jul = '${Constants.monthOb}jul';
  static const String aug = '${Constants.monthOb}aug';
  static const String sept = '${Constants.monthOb}sept';
  static const String oct = '${Constants.monthOb}oct';
  static const String nov = '${Constants.monthOb}nov';
  static const String dec = '${Constants.monthOb}dec';
}
