// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logintoken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginTokenRequest _$LoginTokenRequestFromJson(Map<String, dynamic> json) =>
    LoginTokenRequest(
      grantType: json['grantType'] as String,
      clientId: json['clientId'] as String,
      clientSecret: json['clientSecret'] as String,
      loginToken: json['loginToken'] as String,
    );

Map<String, dynamic> _$LoginTokenRequestToJson(LoginTokenRequest instance) =>
    <String, dynamic>{
      'grantType': instance.grantType,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'loginToken': instance.loginToken,
    };

LoginTokenResponse _$LoginTokenResponseFromJson(Map<String, dynamic> json) =>
    LoginTokenResponse(
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      refreshToken: json['refreshToken'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginTokenResponseToJson(LoginTokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'refreshToken': instance.refreshToken,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      employeeId: (json['employeeId'] as num).toInt(),
      role: json['role'] as String,
      mobileNumber: json['mobileNumber'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'employeeId': instance.employeeId,
      'role': instance.role,
      'mobileNumber': instance.mobileNumber,
    };
