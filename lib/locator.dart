import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/repo/unrestricted_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/provider/weather-provider.dart';

import 'data/remote/api_service.dart';
import 'data/remote/remote_data_source.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final RemoteDataSource remoteDataSource = ApiService();

  /// 💡Tip: There is no point in using 'lazy' singleton
  /// if the instance of class being provided has already
  /// been created.
  locator.registerLazySingleton<RemoteDataSource>(() => remoteDataSource);
  locator.registerLazySingleton(
    () => UnrestrictedRepository(
      remoteDataSource: remoteDataSource,
    ),
  );
  locator.registerFactory<WeatherProvider>(() => WeatherProvider());
}
