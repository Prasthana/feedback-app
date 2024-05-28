// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeesresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesResponse _$EmployeesResponseFromJson(Map<String, dynamic> json) =>
    EmployeesResponse(
      employeesList: (json['employees'] as List<dynamic>?)
          ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeesResponseToJson(EmployeesResponse instance) =>
    <String, dynamic>{
      'employees': instance.employeesList,
    };
