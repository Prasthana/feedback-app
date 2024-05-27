
import 'package:json_annotation/json_annotation.dart';

part 'preparecallresponse.g.dart';

@JsonSerializable()
class PrepareCallResponse {
    int? id;
    String? email;
    Map<String, Permission>? permissions;

    PrepareCallResponse({
        this.id,
        this.email,
        this.permissions,
    });

  factory PrepareCallResponse.fromJson(Map<String, dynamic> json) =>
      _$PrepareCallResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PrepareCallResponseToJson(this);
}

@JsonSerializable()
class Permission {
    Access? access;

    Permission({
        this.access,
    });

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}

enum Access {
    enabled,
    notAvailable
}
