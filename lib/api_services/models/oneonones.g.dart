// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oneonones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOne _$OneOnOneFromJson(Map<String, dynamic> json) => OneOnOne(
      id: (json['id'] as num?)?.toInt(),
      scheduledDate: json['scheduledDate'] == null
          ? null
          : DateTime.parse(json['scheduledDate'] as String),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: json['status'] as String?,
      notes: json['notes'],
      participant: json['participant'] == null
          ? null
          : Participant.fromJson(json['participant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneOnOneToJson(OneOnOne instance) => <String, dynamic>{
      'id': instance.id,
      'scheduledDate': instance.scheduledDate?.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
      'participant': instance.participant,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
