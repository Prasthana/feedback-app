
import 'package:json_annotation/json_annotation.dart';

part 'preparecallresponse.g.dart';

@JsonSerializable()
class PrepareCallResponse {
    User? user;

    PrepareCallResponse({
        this.user,
    });

  factory PrepareCallResponse.fromJson(Map<String, dynamic> json) =>
      _$PrepareCallResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PrepareCallResponseToJson(this);

}

@JsonSerializable()
class User {
    int? id;
    String? email;
    Map<String, Permission>? permissions;

    User({
        this.id,
        this.email,
        this.permissions,
    });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

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

@JsonEnum(fieldRename: FieldRename.snake)
enum Access {
    enabled,
    // Dont remove this - ita false warning - Janakiram
    @JsonKey(name: 'not_available')
    notAvailable
}
