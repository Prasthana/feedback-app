// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_on_one_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOnePoint _$OneOnOnePointFromJson(Map<String, dynamic> json) =>
    OneOnOnePoint(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pointType: json['point_type'] as String?,
      completionComment: json['completion_comment'] as String?,
      title: json['title'] as String?,
      oneOnOneId: json['one_on_one_id'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
    );

Map<String, dynamic> _$OneOnOnePointToJson(OneOnOnePoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('point_type', instance.pointType);
  writeNotNull('completion_comment', instance.completionComment);
  writeNotNull('title', instance.title);
  writeNotNull('one_on_one_id', instance.oneOnOneId);
  writeNotNull('created_by', instance.createdBy);
  writeNotNull('updated_by', instance.updatedBy);
  return val;
}
