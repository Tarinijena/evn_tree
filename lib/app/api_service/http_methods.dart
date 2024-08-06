import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as service;

class HttpMethodsDio {
  HttpMethodsDio._privateConstructor() {
    // Perform any necessary initialization here
    _dio = Dio()
      // ..options.baseUrl = 'https://your-api-base-url.com' // Set your base URL
      ..interceptors.add(LogInterceptor(
          responseBody: true,
          logPrint: (data) {
            if (kDebugMode) {
              log(">>>>>>>>>>>>>>>>>>>>>>>>api_response_log $data");
            }
          })); // Add logging (optional)
    if (kDebugMode) {
      print('MySingleton instance created');
    }
  }

  factory HttpMethodsDio() {
    return _instance;
  }

  static final HttpMethodsDio _instance = HttpMethodsDio._privateConstructor();
  late final Dio _dio;

  Map<String, dynamic> failedMap = {"status": "failed"};

  getMethod({required String api, required Function fun}) async {
    if (kDebugMode) {
      print("<<jks>>>>>API_CALL>>>>>>\n\n\n\n\n$api");
    }
    try {
      service.Response response = await _dio.get(api);
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data, response.statusCode);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else if (response.statusCode == 500) {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(response.data, response.statusCode);
      } else {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(failedMap, response.statusCode);
      }
    } on DioException catch (e) {
      //log("Connector Response Error>>" + jsonEncode(e.message));
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badResponse:
          fun(e.response?.data ?? "", e.response?.statusCode);
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          fun(failedMap, e.response?.statusCode);
          break;
        case DioExceptionType.connectionError:
          fun(failedMap, e.response?.statusCode);
          break;
        default:
          fun(failedMap, e.response?.statusCode);
          break;
      }
    }
  }

  getMethodWithToken({required String api, required Function fun, required String? token}) async {
    if (kDebugMode) {
      print("<<jks>>>>>API_CALL>>>>>>\n\n\n\n\n$api");
    }
    try {
      service.Response response = await _dio.get(
        api,
        options: Options(headers: {
          "Authorization": "Bearer ${(token != null) ? token : ""}",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data, response.statusCode);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else if (response.statusCode == 500) {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(response.data, response.statusCode);
      } else {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(failedMap, response.statusCode);
      }
    } on DioException catch (e) {
      //log("Connector Response Error>>" + jsonEncode(e.message));
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badResponse:
          fun(e.response?.data ?? "", e.response?.statusCode);
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          fun(failedMap, e.response?.statusCode);
          break;
        case DioExceptionType.connectionError:
          fun(failedMap, e.response?.statusCode);
          break;
        default:
          fun(failedMap, e.response?.statusCode);
          break;
      }
    }
  }

  getMethodWithParam({required String api, required Function fun, Map<String, dynamic>? json}) async {
    if (kDebugMode) {
      print("<<jks>>>>>API_CALL>>>>>>\n\n\n\n\n$api");
    }
    try {
      service.Response response = await _dio.get(api, queryParameters: json);
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else if (response.statusCode == 500) {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(response.data);
      } else {
        if (kDebugMode) {
          print("jks>>${response.data}");
        }
        fun(failedMap);
      }
    } on DioException catch (e) {
      //log("Connector Response Error>>" + jsonEncode(e.message));
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badResponse:
          fun(e.response?.data ?? "");
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          fun(failedMap);
          break;
        case DioExceptionType.connectionError:
          fun(failedMap);
          break;
        default:
          fun(failedMap);
          break;
      }
    }
  }

  postMethod({required String api, dynamic json, required Function fun}) async {
    try {
      if (kDebugMode) {
        print("API NAME:>$api");
      }
      service.Response response = await _dio.post(
        api,
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data, response.statusCode);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      }
      /*else if (response.statusCode == 417) {
        fun(response.data);
      }*/
      else {
        if (kDebugMode) {
          print("Message is: >>1");
        }
        fun(failedMap, response.statusCode);
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.unknown:
          fun(failedMap, 1000);
          break;
        case DioExceptionType.badResponse:
          fun(e.response?.data ?? {}, e.response?.statusCode);
        case DioExceptionType.badCertificate:
          fun(failedMap, e.response?.statusCode);
        case DioExceptionType.connectionError:
          fun(failedMap, e.response?.statusCode);
      }
    }
  }

  putMethod({required String api, required post, required Function fun}) async {
    if (kDebugMode) {
      print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n$api");
    }
    try {
      service.Response response = await _dio.put(
        api,
        data: jsonEncode(post),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data, response.statusCode);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else {
        fun(failedMap, response.statusCode);
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.unknown:
          fun(failedMap, e.response?.statusCode);
          break;
        case DioExceptionType.badResponse:
          fun(e.response?.data, e.response?.statusCode);
        case DioExceptionType.badCertificate:
          fun(failedMap, e.response?.statusCode);
        case DioExceptionType.connectionError:
          fun(failedMap, e.response?.statusCode);
      }
    }
  }
}
