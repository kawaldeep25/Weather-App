import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
// import 'package:instaaplan/data/local/jwtParser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/data/remote/remote_data_source.dart';
// import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ApiService implements RemoteDataSource {
  static const String jwt = 'Bearer ';
  static const String authorization = 'Authorization';
  var devBaseUrl = 'api.rozmart.in';
  final _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: 'https://' + Constants.baseUrl,
      contentType: dio.Headers.jsonContentType,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
    ),
  )..interceptors.add(dio.LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  ApiService();

  // Future<List<NewsModel>> fetchTopHeadlines() async {
  //   final response = await _dio.get('/v2/top-headlines', queryParameters: {
  //     'apiKey': Constants.apiKey,
  //     'country': Constants.contry,
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final result = response.data;
  //     log('response is ${response.data.toString()}');
  //     Iterable list = result['articles'];
  //     return list.map((article) => NewsModel.fromJson(article)).toList();
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }
  //
  //
  // Future<List<NewsModel>> getNews(String topicName) async {
  //   final response = await _dio.get('/v2/top-headlines', queryParameters: {
  //     'apiKey': Constants.apiKey,
  //     'country': Constants.contry,
  //     'category': topicName
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final result = response.data;
  //     Iterable list = result['articles'];
  //     return list.map((article) => NewsModel.fromJson(article)).toList();
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }
}
