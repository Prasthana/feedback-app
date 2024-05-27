import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_services.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:network_logger/network_logger.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: ApiManager.baseURL,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ),
);

class ApiManager {
  static const String baseURL =
      'https://pug-stirring-hopefully.ngrok-free.app/';

  static Dio buildDioClient(String base) {
    final dio = Dio()..options = BaseOptions(baseUrl: baseURL);


    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the authorization token to every request
          StorageManager().getData('TOKEN').then((token) {
            options.headers['Authorization'] = 'Bearer $token';
            return handler.next(options); // Continue
          });
        },
      ),
    );
    
    dio.interceptors.add(DioNetworkLogger());

    return dio;
  }

  static final authenticated = RestClient(buildDioClient(baseURL));
  static final public = RestClient(buildDioClient(baseURL));
}
