// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeCreateRequest _$EmployeeCreateRequestFromJson(
        Map<String, dynamic> json) =>
    EmployeeCreateRequest(
      employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeCreateRequestToJson(
        EmployeeCreateRequest instance) =>
    <String, dynamic>{
      'employee': instance.employee,
    };
