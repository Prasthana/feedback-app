// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointResponse _$PointResponseFromJson(Map<String, dynamic> json) =>
    PointResponse(
      oneOnOnePoint: OneOnOnePoint.fromJson(
          json['one_on_one_point'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PointResponseToJson(PointResponse instance) =>
    <String, dynamic>{
      'one_on_one_point': instance.oneOnOnePoint,
    };
