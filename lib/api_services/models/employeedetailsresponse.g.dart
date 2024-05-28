// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeedetailsresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetailsResponse _$EmployeeDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeDetailsResponse(
      employee: json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeDetailsResponseToJson(
        EmployeeDetailsResponse instance) =>
    <String, dynamic>{
      'employee': instance.employee,
    };
