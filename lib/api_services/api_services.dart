
import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/api_services/models/verifyotp.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:retrofit/http.dart';

part 'api_services.g.dart';
 
@RestApi(baseUrl: ApiManager.baseURL)
abstract class RestClient {

  factory RestClient(Dio dio) = _RestClient;

// ************************************************************************
// *********************** API's for Login ***********************

  @POST("users/send_email_auth_code")
  Future<EmailOTPResponse> sendEmailOTP(@Body() EmailOTPRequest request);

  @POST("users/verify_email_auth_code")
  Future<VerifyEmailOTPResponse> verifyEmailOTP(@Body() VerifyEmailOTPRequest request);

  @POST("oauth/token")
  Future<LoginTokenResponse> generateLoginToken(@Body() LoginTokenRequest request);

  @GET("users/prepare")
  Future<PrepareCallResponse> performPrepareCall();

// ************************************************************************
// *********************** API's for One - On - One ***********************

  @GET("/one_on_ones")
  Future<List<OneOnOne>> fetchOneOnOnesList();

  @GET("/one_on_ones")
  Future<OneOnOne> fetchOneOnOneDetails(@Query("param1") String oneononeid);

  @PUT("/one_on_ones")
  Future<OneOnOne> updateOneOnOneDetails(@Query("param1") String oneononeid);

  @POST("/one_on_ones")
  Future<OneOnOne> createOneOnOne(@Body() OneOnOne request);

// ************************************************************************
// *********************** API's for Employee's ***********************

  @GET("/employees")
  Future<List<Employee>> fetchEmployeesList();

// ************************************************************************
// ************************************************************************

}