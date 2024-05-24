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
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
    );

Map<String, dynamic> _$EmailOTPResponseToJson(EmailOTPResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };
