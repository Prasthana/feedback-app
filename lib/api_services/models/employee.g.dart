// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: (json['id'] as num).toInt(),
      employeeNo: json['employee_no'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      designation: json['designation'] as String,
      manager: json['manager'] == null
          ? null
          : Employee.fromJson(json['manager'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'employee_no': instance.employeeNo,
      'name': instance.name,
      'email': instance.email,
      'designation': instance.designation,
      'manager': instance.manager,
    };
