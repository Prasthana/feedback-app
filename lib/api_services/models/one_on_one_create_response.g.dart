// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_on_one_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOneCreateResponse _$OneOnOneCreateResponseFromJson(
        Map<String, dynamic> json) =>
    OneOnOneCreateResponse(
      oneOnOne:
          OneOnOneCreate.fromJson(json['one_on_one'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneOnOneCreateResponseToJson(
        OneOnOneCreateResponse instance) =>
    <String, dynamic>{
      'one_on_one': instance.oneOnOne,
    };

OneOnOneCreate _$OneOnOneCreateFromJson(Map<String, dynamic> json) =>
    OneOnOneCreate(
      id: (json['id'] as num?)?.toInt(),
      startDateTime: json['start_date_time'] as String,
      endDateTime: json['end_date_time'] as String,
      status: json['status'] as String?,
      notes: json['notes'] as String,
      goodAtPoints: json['good_at_points'] as List<dynamic>?,
      yetToImprovePoints: json['yet_to_improve_points'] as List<dynamic>?,
      oneOnOneParticipants: (json['one_on_one_participants'] as List<dynamic>?)
          ?.map((e) => OneOnOneParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      oneOnOneParticipantsAttributes: (json['one_on_one_participants_attribute']
              as List<dynamic>?)
          ?.map((e) =>
              OneOnOneParticipantsAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OneOnOneCreateToJson(OneOnOneCreate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date_time': instance.startDateTime,
      'end_date_time': instance.endDateTime,
      'status': instance.status,
      'notes': instance.notes,
      'good_at_points': instance.goodAtPoints,
      'yet_to_improve_points': instance.yetToImprovePoints,
      'one_on_one_participants': instance.oneOnOneParticipants,
      'one_on_one_participants_attribute':
          instance.oneOnOneParticipantsAttributes,
    };

OneOnOneParticipant _$OneOnOneParticipantFromJson(Map<String, dynamic> json) =>
    OneOnOneParticipant(
      id: (json['id'] as num).toInt(),
      employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneOnOneParticipantToJson(
        OneOnOneParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee,
    };
