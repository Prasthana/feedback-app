import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

/// Interceptor for adding to know which platform
class RequestInterceptor extends Interceptor {
  RequestInterceptor();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // options.headers['API-REQUEST-FROM'] = Platform.isIOS?"IOS":"Android";

   // Add the authorization token to every request
    var token = await StorageManager().getData(constants.loginTokenResponse);
      if (token != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(token);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        var accessToken = mLoginTokenResponse.accessToken;
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options); // Continue
  }
  
}
