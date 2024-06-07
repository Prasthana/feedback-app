import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';


List<Employee> welcomeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String welcomeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Employee {
    int? id;
    @JsonKey(name: 'employee_no')
    String? employeeNo;
    String? name;
    String? designation;
    String? email;
    @JsonKey(name: 'mobile_number')
    String? mobileNumber;
    @JsonKey(name: 'avatar_attachment_url')
    String? avatarAttachmentUrl;
    @JsonKey(name: 'manager')
    Employee? manager;
    @JsonKey(name: 'reporting_manager_id')
    int? reportingManagerId;

    Employee({
        this.id,
        this.employeeNo,
        this.name,
        this.designation,
        this.email,
        this.mobileNumber,
        this.avatarAttachmentUrl,
        this.manager,
        this.reportingManagerId
    });


  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

}

extension EmployeeExtension on Employee {

  CachedNetworkImageProvider? getAvatarImage() {
      if ( avatarAttachmentUrl?.isNotEmpty == true) {
          var imageURL = avatarAttachmentUrl as String;
          return CachedNetworkImageProvider(imageURL);
      }    
    return null;
  }
  
}
