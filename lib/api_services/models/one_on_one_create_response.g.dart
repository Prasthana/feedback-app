// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_on_one_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOneCreateResponse _$OneOnOneCreateResponseFromJson(
        Map<String, dynamic> json) =>
    OneOnOneCreateResponse(
      oneOnOne: OneOnOne.fromJson(json['one_on_one'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneOnOneCreateResponseToJson(
        OneOnOneCreateResponse instance) =>
    <String, dynamic>{
      'one_on_one': instance.oneOnOne,
    };
