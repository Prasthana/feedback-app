// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preparecallresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareCallResponse _$PrepareCallResponseFromJson(Map<String, dynamic> json) =>
    PrepareCallResponse(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      permissions: (json['permissions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Permission.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$PrepareCallResponseToJson(
        PrepareCallResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'permissions': instance.permissions,
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
  Access.notAvailable: 'notAvailable',
};
