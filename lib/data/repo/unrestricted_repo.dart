import 'package:flutter/material.dart';
import 'package:weather_app/data/remote/remote_data_source.dart';

class UnrestrictedRepository {
  RemoteDataSource? _remoteDataSource;

  UnrestrictedRepository({@required remoteDataSource})
      : assert(remoteDataSource != null) {
    _remoteDataSource = remoteDataSource;
  }

  // Future<List<NewsModel>> fetchNewsList() async {
  //   return await _remoteDataSource!.fetchNewsList();
  // }
  //
  // //
  // Future<List<NewsModel>> getNews(String topicName) async {
  //   return await _remoteDataSource!.getNews(topicName);
  // }
}
