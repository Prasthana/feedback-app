import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:json_annotation/json_annotation.dart';
part 'employee_create_request.g.dart';


@JsonSerializable()
class EmployeeCreateRequest {
    @JsonKey(name: 'employee')
    Employee employee;

    EmployeeCreateRequest({
      
        required this.employee,
    });

  factory EmployeeCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeCreateRequestToJson(this);
}