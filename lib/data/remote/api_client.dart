import 'package:airnav_helpdesk/core/config/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_interceptor.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({Dio? dioInstance}) {
    dio =
        dioInstance ??
        Dio(
          BaseOptions(
            baseUrl: EnvConfig.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            responseType: ResponseType.json,
            contentType: "application/json",
          ),
        );

    dio.interceptors.add(ApiInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (o) => debugPrint(o.toString()),
        ),
      );
    }
  }
}
