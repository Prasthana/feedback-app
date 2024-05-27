import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_services.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:network_logger/network_logger.dart';
import 'package:feedbackapp/constants.dart' as constants;


Dio dio = Dio(
  BaseOptions(
    baseUrl: ApiManager.baseURL,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ),
);

class ApiManager {
  static const String baseURL =
      'http://ec2-18-219-231-99.us-east-2.compute.amazonaws.com/';

  static Dio buildDioClient(String base) {
    final dio = Dio()..options = BaseOptions(baseUrl: baseURL);


    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the authorization token to every request
          StorageManager().getData(constants.loginTokenResponse).then((token) {
            if(token != constants.noDataFound){
              Map<String, dynamic>  json = jsonDecode(token);
            var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
            var accessToken = mLoginTokenResponse.accessToken;
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
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
