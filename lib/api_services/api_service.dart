import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_client.dart';
import 'package:feedbackapp/api_services/api_errohandler.dart';
import 'package:feedbackapp/api_services/api_result.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;


class ApiService {
  final ApiClient _apiPublicClient = ApiManager.public;
  final ApiClient _apiAuthenticatedClient = ApiManager.authenticated;

  Future<ApiResult<EmailOTPResponse?>> sendOTP(EmailOTPRequest request) async {
    EmailOTPResponse? response;
    try {
      dynamic jsonResponse = await _apiPublicClient.sendEmailOTP(request);

      // return ApiResult()..setData(response);
      return ApiResult()..setData(jsonResponse);

    } catch (e, _) {
      //checking if the exception from dio then set the dio otherwise set other exception
      if (e is DioException) {
        logger.e("exception is $e and $_");
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e),);
      }
      return ApiResult()..setException(ErrorHandler.otherException(),);
    }
  }

Future<ApiResult<PrepareCallResponse?>> makePrepareCall() async {
 
    try {
      dynamic jsonResponse = await _apiAuthenticatedClient.performPrepareCall();

      return ApiResult()..setData(jsonResponse);
    } catch (e, _) {
      //checking if the exception from dio then set the dio otherwise set other exception
      if (e is DioException) {
        logger.e("exception is $e and $_");
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e),);
      }
      return ApiResult()..setException(ErrorHandler.otherException(),);
    }

  }


Future<ApiResult<LoginTokenResponse?>> makeRefreshTokenCall(String loginToken) async {
 
    try {
      var request = LoginTokenRequest(
        grantType: constants.grantTypePassword,
        clientId: constants.clientId,
        clientSecret: constants.clientSecret,
        loginToken: loginToken);
      dynamic jsonResponse = await _apiAuthenticatedClient.generateLoginToken(request);

      return ApiResult()..setData(jsonResponse);
    } catch (e, _) {
      //checking if the exception from dio then set the dio otherwise set other exception
      if (e is DioException) {
        logger.e("exception is $e and $_");
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e),);
      }
      return ApiResult()..setException(ErrorHandler.otherException(),);
    }

  }

  
}