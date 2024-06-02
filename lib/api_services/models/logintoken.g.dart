// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logintoken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginTokenRequest _$LoginTokenRequestFromJson(Map<String, dynamic> json) =>
    LoginTokenRequest(
      grantType: json['grant_type'] as String,
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      loginToken: json['login_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$LoginTokenRequestToJson(LoginTokenRequest instance) {
  final val = <String, dynamic>{
    'grant_type': instance.grantType,
    'client_id': instance.clientId,
    'client_secret': instance.clientSecret,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('login_token', instance.loginToken);
  writeNotNull('refresh_token', instance.refreshToken);
  return val;
}

LoginTokenResponse _$LoginTokenResponseFromJson(Map<String, dynamic> json) =>
    LoginTokenResponse(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
      refreshToken: json['refresh_token'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginTokenResponseToJson(LoginTokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'created_at': instance.createdAt,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      employeeId: (json['employee_id'] as num?)?.toInt(),
      role: json['role'] as String?,
      mobileNumber: json['mobile_number'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'employee_id': instance.employeeId,
      'role': instance.role,
      'mobile_number': instance.mobileNumber,
    };
