
import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/verifyotp.dart';
import 'package:retrofit/http.dart';
part 'api_services.g.dart';
 
@RestApi(baseUrl: "https://pug-stirring-hopefully.ngrok-free.app/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("users/send_email_auth_code")
  Future<EmailOTPResponse> sendEmailOTP(@Body() EmailOTPRequest request);

  @POST("users/verify_email_auth_code")
  Future<VerifyEmailOTPResponse> verifyEmailOTP(@Body() VerifyEmailOTPRequest request);

  @POST("oauth/token")
  Future<LoginTokenResponse> generateLoginToken(@Body() LoginTokenRequest request);

}