// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeerequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRequest _$EmployeeRequestFromJson(Map<String, dynamic> json) =>
    EmployeeRequest(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      mobileNumber: json['mobile_number'] as String,
    );

Map<String, dynamic> _$EmployeeRequestToJson(EmployeeRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'mobile_number': instance.mobileNumber,
    };
