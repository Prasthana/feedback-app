import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_result.dart';
import 'package:feedbackapp/api_services/api_service.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

/// using this key when we don't have direct access with Build context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// This class is used for handling 401
/// other errors handling in Api Result Generic class
class TokenInterceptor extends Interceptor {
  final Dio dio;
  final ApiService? _apiService;

  TokenInterceptor(this.dio,this._apiService);

  void navigateToLogin() {
    // //clearing data
    // AppStorage().clearData();
    // // calling sign out API
    // ApiService().signOut();
    // //navigate to login add any back stack if you want
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LoginView(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Logger.log(
    //     functionName: "TokenInterceptor",
    //     msg: "Reached ${err.type} ${err.response?.statusCode}");

    //checks the response code
    if (err.response?.statusCode == 401) {
      if (!err.requestOptions.extra.containsKey('retry')) {
        err.requestOptions.extra['retry'] = true;

        var sm = StorageManager();
        sm.getData(constants.loginTokenResponse).then((val) async {
          if (val != constants.noDataFound) {
            Map<String, dynamic> json = jsonDecode(val);
            var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
            logger.d('val -- $json');

            ApiResult<LoginTokenResponse?> value = await ApiService.sharedInstance.makeRefreshTokenCall(mLoginTokenResponse.refreshToken ?? "");

            dynamic response = value.data;
            if (response != null) {
              // Save the token information
              // TO DO

              // Retry API Call
              try {
                // retry the API call
                final response = await dio.fetch(err.requestOptions);
                handler.resolve(response);
              } on DioException catch (e) {
                logger.e("api:: called retry exception $e");
                // If an error occurs during the api call , reject the handler and sending to error to API Result generic class
                //errors like any validation issue from API or whatever
                return handler.reject(e);
              }
            } else {
              navigateToLogin();
            }
          }
        });
      } else {
        // if the API status code not contains sending to API Result class
        return handler.next(err);
      }
    }
  }
}
