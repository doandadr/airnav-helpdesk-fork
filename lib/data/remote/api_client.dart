import 'package:airnav_helpdesk/core/config/env_config.dart';
import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  )..interceptors.add(ApiInterceptor());
}
