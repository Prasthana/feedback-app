
import 'package:dio/dio.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:flutter/material.dart';

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



      } else {
        // if the API status code not contains sending to API Result class
        return handler.next(err);
      }
    }

  }
}
