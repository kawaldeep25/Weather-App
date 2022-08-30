import 'package:intl/intl.dart';

const weather_api_key = '4b9c8d0dab0f16f0e22d0f49631364d6';
String getFormattedDate(int date, String format) =>
    DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(date * 1000));
const WEATHER_ICON_PREFIX = 'https://openweathermap.org/img/wn/';
const WEATHER_ICON_SUFFIX = '@4x.png';
// const WEATHER_ICON_PREFIX = 'https://openweathermap.org/img/w/';
// const WEATHER_ICON_SUFFIX = '.png';
const String image =
    'https://api.unsplash.com/search/photos?client_id=-RzYRItrgrN6YbSd3hYgUogeUuRcu3HJPldJ5G5bmIw&page=1&per_page=5&orientation=portrait&query=delhi';
const cities = [
  'Brussels',
  'Dhaka',
  'Istanbul',
  'Kazan',
  'London',
  'Manchester',
  'Oslo',
  'Stockholm'
];
