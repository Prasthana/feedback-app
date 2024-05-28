// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userlogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
    )..loginToken = json['login_token'] as String?;

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'id': instance.id,
      'login_token': instance.loginToken,
      'email': instance.email,
    };
