import 'package:json_annotation/json_annotation.dart';

part 'userlogin.g.dart';

@JsonSerializable()
class UserLogin {
    int? id;
    @JsonKey(name: 'login_token')
    String? loginToken;
    String? email;

    UserLogin({
        this.id,
        this.email,
    });
  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);

}



// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
