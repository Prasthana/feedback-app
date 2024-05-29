// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: (json['id'] as num).toInt(),
      employeeNo: json['employee_no'] as String?,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      avatarAttachmentUrl: json['avatar_attachment_url'] as String?,
      manager: json['manager'] == null
          ? null
          : Employee.fromJson(json['manager'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'employee_no': instance.employeeNo,
      'name': instance.name,
      'designation': instance.designation,
      'email': instance.email,
      'mobile_number': instance.mobileNumber,
      'avatar_attachment_url': instance.avatarAttachmentUrl,
      'manager': instance.manager,
    };
