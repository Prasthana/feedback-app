import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';


List<Employee> welcomeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String welcomeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Employee {
    int id;
    @JsonKey(name: 'employee_no')
    String employeeNo;
    String name;
    String email;
    String designation;
    Employee? manager;

    Employee({
        required this.id,
        required this.employeeNo,
        required this.name,
        required this.email,
        required this.designation,
        this.manager,
    });


  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

}
