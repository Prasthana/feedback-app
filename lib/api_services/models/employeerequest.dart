import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'employeerequest.g.dart';

@JsonSerializable()
class EmployeeRequest {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'avatar')
  String avatar;
  @JsonKey(name: 'mobile_number')
  String mobileNumber;

  EmployeeRequest({
    required this.name,
    required this.avatar,
    required this.mobileNumber,
  });

  factory EmployeeRequest.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeRequestToJson(this);
}
