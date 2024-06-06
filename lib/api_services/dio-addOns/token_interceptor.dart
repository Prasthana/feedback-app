import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/login/login_view.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

/// using this key when we don't have direct access with Build context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// This class is used for handling 401
/// other errors handling in Api Result Generic class
class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

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
            var refreshTokenStatus =
                await refreshLoginToken(mLoginTokenResponse.refreshToken ?? "");
                logger.d("refreshTokenStatus $refreshTokenStatus");
            try {
              // retry the API call
              final response = await dio.fetch(err.requestOptions);
              handler.resolve(response);
            } on DioException catch (e) {
              logger.e("api:: called retry exception $e");
              // If an error occurs during the api call , reject the handler and sending to error to API Result generic class
              //errors like any validation issue from API or whatever
              navigateToLogin();
              return handler.reject(e);
            }
          }
        });
      }
    }
    // if the API status code not contains sending to API Result class
    return handler.next(err);
  }

  Future<bool> refreshLoginToken(String refreshToken) async {
    var request = LoginTokenRequest(
        grantType: constants.grantTypeRefreshToken,
        clientId: constants.clientId,
        clientSecret: constants.clientSecret,
        refreshToken: refreshToken);

    var success =
        await ApiManager.authenticated.generateLoginToken(request).then((val) {
      // do some operation
      logger.e('email response -- ${val.toJson()}');
      String user = jsonEncode(val.toJson());
      var sm = StorageManager();

      sm.saveData(constants.loginTokenResponse, user);

      sleep(const Duration(seconds: 1));

      return true;
    }).catchError((obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case const (DioException):
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioException).response;
          logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
          break;
        default:
          break;
      }
      return false;
    });
    return success;
  }
}
