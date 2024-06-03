import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

/// Interceptor for adding to know which platform
class RequestInterceptor extends Interceptor {
  RequestInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['API-REQUEST-FROM'] = Platform.isIOS?"IOS":"Android";

   // Add the authorization token to every request
    StorageManager().getData(constants.loginTokenResponse).then((token) {
      if (token != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(token);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        var accessToken = mLoginTokenResponse.accessToken;
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options); // Continue
    });
     
    super.onRequest(options, handler);
  }
}
