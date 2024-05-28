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
      userLogin: json['user_login'] == null
          ? null
          : UserLogin.fromJson(json['user_login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyEmailOTPResponseToJson(
        VerifyEmailOTPResponse instance) =>
    <String, dynamic>{
      'user_login': instance.userLogin,
    };
