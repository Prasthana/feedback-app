
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employeesresponse.g.dart';

@JsonSerializable()
class EmployeesResponse {
  
    @JsonKey(name: 'employees')
    List<Employee>? employeesList;

    EmployeesResponse({
        this.employeesList,
    });

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeesResponseToJson(this);

}