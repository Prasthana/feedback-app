import 'package:dio/dio.dart';

Dio buildDioClient(String base) {
  final dio = Dio()..options = BaseOptions(baseUrl: base);

  // dio.interceptors.addAll(
  //   [
  //     TokenInterceptor(),
  //     DioLogInterceptor(logger: logger),
  //     LoggyDioInterceptor()
  //   ],
  // );
  return dio;
}
