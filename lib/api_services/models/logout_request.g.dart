// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) =>
    LogoutRequest(
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      loginToken: json['token'] as String?,
    );

Map<String, dynamic> _$LogoutRequestToJson(LogoutRequest instance) {
  final val = <String, dynamic>{
    'client_id': instance.clientId,
    'client_secret': instance.clientSecret,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.loginToken);
  return val;
}
