import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../main/main_dev.dart';
import 'api_config.dart';

class ApiServices extends Api {
  Dio dio = Dio();

  ApiServices() {
    dio.options = baseOption;
    if (kDebugMode) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            log(
              "=========================================================================",
            );
            log("➡️ Request: ${options.uri}");
            log("➡️ Request Data: ${options.data}");
            log("➡️ Headers: ${options.headers}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            log(
              "=========================================================================",
            );
            log(
              "✅ Response: ${response.statusCode} => ${JsonEncoder.withIndent(" " * 4).convert(response.data)}",
            );

            return handler.next(response);
          },
          onError: (DioException e, handler) {
            log(
              "=========================================================================",
            );
            log("❌ Error: ${e.response?.statusCode} => ${e.response?.data}");
            return handler.next(e);
          },
        ),
      );
    }
  }

  @override
  Future<Response> get({required String endpoint}) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  BaseOptions get baseOption => BaseOptions(baseUrl: Info.appUrl);
}