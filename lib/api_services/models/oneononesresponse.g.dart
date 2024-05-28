// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oneononesresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOnesResponse _$OneOnOnesResponseFromJson(Map<String, dynamic> json) =>
    OneOnOnesResponse(
      oneononesList: (json['one_on_ones'] as List<dynamic>?)
          ?.map((e) => OneOnOne.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OneOnOnesResponseToJson(OneOnOnesResponse instance) =>
    <String, dynamic>{
      'one_on_ones': instance.oneononesList,
    };
