// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preparecallresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareCallResponse _$PrepareCallResponseFromJson(Map<String, dynamic> json) =>
    PrepareCallResponse(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrepareCallResponseToJson(
        PrepareCallResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      permissions: (json['permissions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Permission.fromJson(e as Map<String, dynamic>)),
      ), 
      employee: Employee.fromJson(json["employee"]),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'permissions': instance.permissions,
      "employee": instance.employee.toJson(),
    };

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      access: $enumDecodeNullable(_$AccessEnumMap, json['access']),
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'access': _$AccessEnumMap[instance.access],
    };

const _$AccessEnumMap = {
  Access.enabled: 'enabled',
  Access.notAvailable: 'not_available',
};
