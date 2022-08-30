import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {
  static bool apiDebuggin = true;
  static Dio? dio;

  static Dio getClient() {
    if (dio == null) {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: 'https://' + 's5awbly2a5s5apcghsin.scratchrobots.com',
        connectTimeout: 60000,
        receiveTimeout: 60000,
        contentType: 'application/json',
        responseType: ResponseType.json,
      );

      dio = Dio(baseOptions);

      dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // log("$options");
          String? token;
          // UserModel? userModel = DataRepo.getInstance().userRepo.getSavedUser();

          // if (userModel != null) {
          //   // token = "QWEQWEQWEQWE";
          //   token = userModel.token;
          // } else {
          //   token = "";
          // }

          log("$token");

          options.headers.addAll({'authorization': ""});
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          if (apiDebuggin) {
            debugDioResponse(response);
          }
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          if (apiDebuggin) {
            debugDioError(e);
          }
          log("$e");
          return handler.next(e);
        },
      ));
    }
    return dio!;
  }

  static void clean() {
    dio = null;
  }

  static void debugDioError(DioError error) {
    log("+++++++++++++++Request++++++++++++++++++++");
    log("Url - " + error.requestOptions.baseUrl + error.requestOptions.path);
    log("Type - " + error.requestOptions.method);
    log("Headers - " + error.requestOptions.headers.toString());
    log("Request - " + jsonEncode(error.requestOptions.data));
    log("QueryParameters - " + error.requestOptions.queryParameters.toString());
    log("+++++++++++++++++++++++++++++++++++");

    if (error.response != null) {
      log("+++++++++++++++Response++++++++++++++++++++");
      log("Response Code - " + error.response!.statusCode.toString());
      log("Response - " + error.response!.data.toString());
      log("+++++++++++++++++++++++++++++++++++");
    } else {
      log("+++++++++++++++Response NULL++++++++++++++++++++");
    }

    log("+++++++++++++++Stack Trace++++++++++++++++++++");
    log("StackTrace - " + error.toString());
    log("+++++++++++++++++++++++++++++++++++");
  }

  static void debugDioResponse(Response response) {
    log("+++++++++++++++Request++++++++++++++++++++");
    log("Url - " +
        response.requestOptions.baseUrl +
        response.requestOptions.path);
    log("Type - " + response.requestOptions.method);
    log("Headers - " + jsonEncode(response.requestOptions.headers));
    log("Request - " + jsonEncode(response.requestOptions.data));
    log("QueryParameters - " +
        response.requestOptions.queryParameters.toString());
    log("+++++++++++++++++++++++++++++++++++");

    log("+++++++++++++++Response++++++++++++++++++++");
    log("Response Code - " + response.statusCode.toString());
    log("Response - " + jsonEncode(response.data));
    log("+++++++++++++++++++++++++++++++++++");
  }
}
