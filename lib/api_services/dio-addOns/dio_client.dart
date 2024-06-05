
import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/dio-addOns/request_interceptor.dart';
import 'package:feedbackapp/api_services/dio-addOns/token_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:network_logger/network_logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio buildDioClient(String base) {

  // displaying for API call log
    final prettyDioLogger = PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    );
    
  final dio = Dio();
  dio.options = BaseOptions(baseUrl: base,
                            connectTimeout: const Duration(milliseconds: 5000),
                            receiveTimeout: const Duration(milliseconds: 3000),
                           );

  
  dio.interceptors.add(RequestInterceptor());
  dio.interceptors.add(DioNetworkLogger());
  dio.interceptors.add(TokenInterceptor(dio));

    if (!kReleaseMode) {
      dio.interceptors.add(prettyDioLogger);
    }

  return dio;
}
