
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeedetailsresponse.dart';
import 'package:feedbackapp/api_services/models/employeerequest.dart';
import 'package:feedbackapp/api_services/models/employeesresponse.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_request.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/one_on_ones_list_response.dart';
import 'package:feedbackapp/api_services/models/oneononeresponse.dart';
import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/api_services/models/oneonone.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/api_services/models/verifyotp.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';
 
@RestApi(baseUrl: ApiManager.baseURL)
abstract class ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;

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
  Future<OneOnOnesResponse> fetchOneOnOnesList();

  @GET("/one_on_ones/{oneononeid}")
  Future<OneOnOneCreateResponse> fetchOneOnOneDetails(@Path("oneononeid") int oneononeid);

  @PUT("/one_on_ones/{oneononeid}")
  Future<OneOnOneResponse> updateOneOnOneDetails(@Body() OneOnOneCreateRequest request, @Path("oneononeid") int oneononeid);
  
  @POST("/one_on_ones")
  Future<OneOnOneCreateResponse> createOneOnOne(@Body() OneOnOneCreateRequest request);

   @GET("/one_on_ones")
  Future<OneOnOnesListResponse> fetchEmployeePastOneOnOns(@Query("time_period") String timePeriod, @Query("employee_id") int employeeId);

// ************************************************************************
// *********************** API's for Employee's ***********************

  @GET("/employees")
  Future<EmployeesResponse> fetchEmployeesList();

  @GET("/employees/{employeeId}")
  Future<EmployeeDetailsResponse> fetchEmployeesDetails(@Path("employeeId") int employeeId);

  @MultiPart()
  @PUT("/employees/{employeeId}")
  Future<EmployeeDetailsResponse> updateEmployeesDetails(@Path("employeeId") int employeeId, @Part(name : "employee[avatar]") File request);

  @PUT("/employees/{employeeId}")
  Future<EmployeeDetailsResponse> updateEmployeesMobile(@Path("employeeId") int employeeId, @Body() EmployeeRequest request);


  @POST("/employees")
  Future<Employee> createEmployee(@Body() OneOnOne request);

  @DELETE("/employees")
  Future<Employee> deleteEmployee(@Query("param1") String employeeId);

// ************************************************************************
// ************************************************************************

}