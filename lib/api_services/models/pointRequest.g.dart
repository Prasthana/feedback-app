// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointRequest _$PointRequestFromJson(Map<String, dynamic> json) => PointRequest(
      oneOnOnePoint: OneOnOnePoint.fromJson(
          json['one_on_one_point'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PointRequestToJson(PointRequest instance) =>
    <String, dynamic>{
      'one_on_one_point': instance.oneOnOnePoint,
    };

OneOnOnePoint _$OneOnOnePointFromJson(Map<String, dynamic> json) =>
    OneOnOnePoint(
      id: (json['id'] as num?)?.toInt(),
      completionComment: json['completion_comment'],
      title: json['title'] as String?,
      markAsDone: json['mark_as_done'] as bool?,
    );

Map<String, dynamic> _$OneOnOnePointToJson(OneOnOnePoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('completion_comment', instance.completionComment);
  writeNotNull('title', instance.title);
  writeNotNull('mark_as_done', instance.markAsDone);
  return val;
}
