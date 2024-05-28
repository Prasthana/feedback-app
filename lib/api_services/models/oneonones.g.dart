// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oneonones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOne _$OneOnOneFromJson(Map<String, dynamic> json) => OneOnOne(
      startDateTime: json['start_date_time'] == null
          ? null
          : DateTime.parse(json['start_date_time'] as String),
      endDateTime: json['end_date_time'] == null
          ? null
          : DateTime.parse(json['end_date_time'] as String),
      notes: json['notes'] as String,
      oneOnOneParticipantsAttributes:
          (json['one_on_one_participants_attributes'] as List<dynamic>?)
              ?.map((e) => OneOnOneParticipantsAttribute.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$OneOnOneToJson(OneOnOne instance) => <String, dynamic>{
      'start_date_time': instance.startDateTime?.toIso8601String(),
      'end_date_time': instance.endDateTime?.toIso8601String(),
      'notes': instance.notes,
      'one_on_one_participants_attributes':
          instance.oneOnOneParticipantsAttributes,
    };

OneOnOneParticipantsAttribute _$OneOnOneParticipantsAttributeFromJson(
        Map<String, dynamic> json) =>
    OneOnOneParticipantsAttribute(
      employeeId: (json['employee_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OneOnOneParticipantsAttributeToJson(
        OneOnOneParticipantsAttribute instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
    };
