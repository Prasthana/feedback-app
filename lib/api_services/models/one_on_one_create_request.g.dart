// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_on_one_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOneCreateRequest _$OneOnOneCreateRequestFromJson(
        Map<String, dynamic> json) =>
    OneOnOneCreateRequest(
      oneOnOne: OneOnOne.fromJson(json['one_on_one'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneOnOneCreateRequestToJson(
        OneOnOneCreateRequest instance) =>
    <String, dynamic>{
      'one_on_one': instance.oneOnOne,
    };

OneOnOneParticipantsAttribute _$OneOnOneParticipantsAttributeFromJson(
        Map<String, dynamic> json) =>
    OneOnOneParticipantsAttribute(
      employeeId: (json['employee_id'] as num).toInt(),
    );

Map<String, dynamic> _$OneOnOneParticipantsAttributeToJson(
        OneOnOneParticipantsAttribute instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
    };
