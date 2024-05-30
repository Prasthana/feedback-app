// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_on_ones_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneOnOnesListResponse _$OneOnOnesListResponseFromJson(
        Map<String, dynamic> json) =>
    OneOnOnesListResponse(
      oneononesList: (json['one_on_ones'] as List<dynamic>?)
          ?.map((e) => OneOnOneCreate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OneOnOnesListResponseToJson(
        OneOnOnesListResponse instance) =>
    <String, dynamic>{
      'one_on_ones': instance.oneononesList,
    };
