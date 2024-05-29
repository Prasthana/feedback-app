import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:json_annotation/json_annotation.dart';
part 'employeedetailsresponse.g.dart';


@JsonSerializable()
class EmployeeDetailsResponse {
    @JsonKey(name: 'employee')
    Employee? employee;

    EmployeeDetailsResponse({      
        required this.employee,
    });

  factory EmployeeDetailsResponse.fromJson(Map<String, dynamic> json) => _$EmployeeDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeDetailsResponseToJson(this);
}