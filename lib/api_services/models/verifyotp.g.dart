// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyotp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailOTPRequest _$VerifyEmailOTPRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOTPRequest(
      id: (json['id'] as num).toInt(),
      emailAuthCode: json['email_auth_code'] as String,
    );

Map<String, dynamic> _$VerifyEmailOTPRequestToJson(
        VerifyEmailOTPRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email_auth_code': instance.emailAuthCode,
    };

VerifyEmailOTPResponse _$VerifyEmailOTPResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOTPResponse(
      id: (json['id'] as num).toInt(),
      loginToken: json['login_token'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$VerifyEmailOTPResponseToJson(
        VerifyEmailOTPResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login_token': instance.loginToken,
      'email': instance.email,
    };
