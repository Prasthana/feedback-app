// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oneonone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOne _$OneOnOneFromJson(Map<String, dynamic> json) => OneOnOne(
      id: (json['id'] as num?)?.toInt(),
      startDateTime: json['start_date_time'] as String?,
      endDateTime: json['end_date_time'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      goodAtPoints: (json['good_at_points'] as List<dynamic>?)
          ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      yetToImprovePoints: (json['yet_to_improve_points'] as List<dynamic>?)
          ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      oneOnOneParticipants: (json['one_on_one_participants'] as List<dynamic>?)
          ?.map((e) => OneOnOneParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      oneOnOneParticipantsAttributes:
          (json['one_on_one_participants_attributes'] as List<dynamic>?)
              ?.map((e) => OneOnOneParticipantsAttribute.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$OneOnOneToJson(OneOnOne instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('start_date_time', instance.startDateTime);
  writeNotNull('end_date_time', instance.endDateTime);
  writeNotNull('status', instance.status);
  writeNotNull('notes', instance.notes);
  writeNotNull('good_at_points', instance.goodAtPoints);
  writeNotNull('yet_to_improve_points', instance.yetToImprovePoints);
  writeNotNull('one_on_one_participants', instance.oneOnOneParticipants);
  writeNotNull('one_on_one_participants_attributes',
      instance.oneOnOneParticipantsAttributes);
  return val;
}

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      id: (json['id'] as num).toInt(),
      completionComment: json['completionComment'],
      title: json['title'] as String,
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'id': instance.id,
      'completionComment': instance.completionComment,
      'title': instance.title,
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
