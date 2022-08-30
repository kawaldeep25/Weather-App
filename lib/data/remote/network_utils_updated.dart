import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'package:http/src/streamed_response.dart';

class NetworkUtils {
  static Future get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    var responseJson;
    try {
      final response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      print('status code is ${response.statusCode}');
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } catch (e) {
      print('error is ${e.toString()}');
      if (e is TimeoutException) {
        throw TimeoutException('Network Timeout');
      } else if (e is SocketException) {
        throw SocketException('No Internet connection');
      } else {
        throw e;
      }
    }
    return jsonDecode(responseJson.body);
  }

  static Future post(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) =>
      _helper(
        'POST',
        url,
        headers: headers!,
        body: body!,
      );

  static Future _helper(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    var responseJson;
    try {
      final request = http.Request(method, url);
      if (body != null) {
        request.bodyFields = body;
      }
      if (headers != null) {
        request.headers.addAll(headers);
      }
      StreamedResponse streamedResponse =
          await request.send().timeout(Duration(seconds: 45));

      final statusCode = streamedResponse.statusCode;
      print('status code is $statusCode');

//      final decoded =
//          json.decode(await streamedResponse.stream.bytesToString());

//      print('decoded data is ${decoded.toString()}');

      responseJson = _returnResponse(streamedResponse);
    } catch (e) {
      print('error is ${e.toString()}');
      if (e is TimeoutException) {
        throw TimeoutException('Network Timeout');
      } else if (e is SocketException) {
        throw SocketException('No Internet connection');
      } else {
        throw e;
      }
    }
    return json.decode(await responseJson.stream.bytesToString());
  }

  static Future put(
    Uri url, {
    Map<String, String>? headers,
    body,
  }) =>
      _helper(
        'PUT',
        url,
        headers: headers,
        body: body,
      );

  static Future delete(Uri url, {Map<String, String>? headers, body}) async {
    var responseJson;
    try {
      final response = await http.delete(url, headers: headers);

      print('status code is ${response.statusCode}');

      responseJson = _returnResponse(response);
    } catch (e) {
      print('error is ${e.toString()}');
      if (e is TimeoutException) {
        throw TimeoutException('Network Timeout');
      } else if (e is SocketException) {
        throw SocketException('No Internet connection');
      } else {
        throw e;
      }
    }
    return jsonDecode(responseJson.body);
  }

  static _returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        return response;
      case 401:
        return response;
      case 404:
        throw NotFound("404");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server: ${response.statusCode}');
    }
  }
}
