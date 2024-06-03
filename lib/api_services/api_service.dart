import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_client.dart';
import 'package:feedbackapp/api_services/api_errohandler.dart';
import 'package:feedbackapp/api_services/api_result.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';

class ApiService {
  final ApiClient _apiPublicClient = ApiManager.public;

  Future<ApiResult<EmailOTPResponse?>> sendOTP(EmailOTPRequest request) async {
    EmailOTPResponse? response;
    try {
      dynamic jsonResponse = await _apiPublicClient.sendEmailOTP(request);

      // Parse each JSON object into a SampleResponse object
      response =
          jsonResponse.map((json) => EmailOTPResponse.fromJson(json));

      return ApiResult()..setData(response);
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
 
    PrepareCallResponse? response;
    try {
      dynamic jsonResponse = await _apiPublicClient.performPrepareCall();

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

  performPrepareCall() {}
}