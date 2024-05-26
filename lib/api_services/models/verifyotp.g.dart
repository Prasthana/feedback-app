// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyotp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailOTPRequest _$VerifyEmailOTPRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOTPRequest(
      id: (json['id'] as num).toInt(),
      emailAuthCode: json['emailAuthCode'] as String,
    );

Map<String, dynamic> _$VerifyEmailOTPRequestToJson(
        VerifyEmailOTPRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emailAuthCode': instance.emailAuthCode,
    };

VerifyEmailOTPResponse _$VerifyEmailOTPResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOTPResponse(
      id: (json['id'] as num).toInt(),
      loginToken: json['loginToken'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$VerifyEmailOTPResponseToJson(
        VerifyEmailOTPResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginToken': instance.loginToken,
      'email': instance.email,
    };
