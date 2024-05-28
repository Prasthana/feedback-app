import 'package:json_annotation/json_annotation.dart';

part 'logintoken.g.dart';

@JsonSerializable()
class LoginTokenRequest {
  @JsonKey(name: 'grant_type')
  String grantType;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;
  @JsonKey(name: 'login_token')
  String loginToken;

  LoginTokenRequest({required this.grantType, 
                          required this.clientId, 
                          required this.clientSecret, 
                          required this.loginToken, 
                          });

  factory LoginTokenRequest.fromJson(Map<String, dynamic> json) => _$LoginTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginTokenRequestToJson(this);

}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


@JsonSerializable()
class LoginTokenResponse {
    @JsonKey(name: 'access_token')
    String? accessToken;
    @JsonKey(name: 'token_type')
    String? tokenType;
    @JsonKey(name: 'expires_in')
    int? expiresIn;
    @JsonKey(name: 'refresh_token')
    String? refreshToken;
    @JsonKey(name: 'created_at')
    int? createdAt;
    User? user;

    LoginTokenResponse({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
        required this.refreshToken,
        required this.createdAt,
        required this.user,
    });

  factory LoginTokenResponse.fromJson(Map<String, dynamic> json) => _$LoginTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginTokenResponseToJson(this);
}

@JsonSerializable()
class User {
    int? id;
    String? email;
    @JsonKey(name: 'created_at')
    DateTime? createdAt;
    @JsonKey(name: 'updated_at')
    DateTime? updatedAt;
    @JsonKey(name: 'employee_id')
    int? employeeId;
    String? role;
    @JsonKey(name: 'mobile_number')
    String? mobileNumber;

    User({
        required this.id,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
        required this.employeeId,
        required this.role,
        required this.mobileNumber,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
