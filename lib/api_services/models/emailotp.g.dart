// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emailotp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailOTPRequest _$EmailOTPRequestFromJson(Map<String, dynamic> json) =>
    EmailOTPRequest(
      email: json['email'] as String,
      deviceType: json['deviceType'] as String,
    );

Map<String, dynamic> _$EmailOTPRequestToJson(EmailOTPRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'deviceType': instance.deviceType,
    };

EmailOTPResponse _$EmailOTPResponseFromJson(Map<String, dynamic> json) =>
    EmailOTPResponse(
      userLogin: json['user_login'] == null
          ? null
          : UserLogin.fromJson(json['user_login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmailOTPResponseToJson(EmailOTPResponse instance) =>
    <String, dynamic>{
      'user_login': instance.userLogin,
    };
