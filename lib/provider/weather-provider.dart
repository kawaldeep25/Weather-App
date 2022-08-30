import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/current-weather-model.dart';
import 'package:weather_app/models/forecast-weather-model.dart';
import 'package:weather_app/config/utils.dart';
import 'package:http/http.dart' as Http;
import 'package:weather_app/models/get_location_images.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentWeatherResponse? _current;
  ForecastWeatherResponse? _forecast;
  GetLocationImages? _getLocationImages;
  GetLocationImages get getLocationImages => _getLocationImages!;
  CurrentWeatherResponse get getCurrentData => _current!;
  ForecastWeatherResponse get getforecastData => _forecast!;

  Future fetchCurrentData(Position position) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$weather_api_key';

    try {
      final response = await Http.get(Uri.parse(url));
      final responseMap = jsonDecode(response.body);
      log(response.body);
      _current = CurrentWeatherResponse.fromJson(responseMap);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  // Future<WeatherResponse?> getWeather(WeatherRequest data) async {
  //   WeatherResponse? res;
  //   try {
  //     await _dio.get(
  //       '/data/2.5/onecall',
  //       json: data.toJson(),
  //     ).then((response) {
  //       if (response.data != null) {
  //         res = WeatherResponse.fromJson(response.data);
  //       } else {
  //         log('response.data == null');
  //       }
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return res;
  // }
  //

  // Future<LocationResponse?> getLocation(LocationRequest data) async {
  //   LocationResponse? res;
  //   try {
  //     await _dio.get(
  //       '/geo/1.0/reverse',
  //       json: data.toJson(),
  //     ).then((response) {
  //       if (response.data != null) {
  //         res = (response.data as List).map((e) => LocationResponse.fromJson(e)).toList()[0];
  //       } else {
  //         log('response.data == null');
  //       }
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return res;
  // }
  Future fetchForecastData(Position position) async {
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&cnt=90&units=metric&appid=$weather_api_key';

    try {
      final response = await Http.get(Uri.parse(url));
      final responseMap = jsonDecode(response.body);
      // log(response.body);

      _forecast = ForecastWeatherResponse.fromJson(responseMap);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<GetLocationImages> fetchLocationImage(String query) async {
    String url =
        'https://api.unsplash.com/search/photos?client_id=-RzYRItrgrN6YbSd3hYgUogeUuRcu3HJPldJ5G5bmIw&page=1&per_page=5&orientation=portrait&query=$query';

    try {
      final response = await Http.get(Uri.parse(url));
      final responseMap = jsonDecode(response.body);

      _getLocationImages = GetLocationImages.fromJson(responseMap);
      return _getLocationImages!;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }
}
