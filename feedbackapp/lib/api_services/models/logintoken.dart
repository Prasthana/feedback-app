import 'package:json_annotation/json_annotation.dart';

part 'logintoken.g.dart';

@JsonSerializable()
class LoginTokenRequest {
  String grantType;
  String clientId;
  String clientSecret;
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
    String accessToken;
    String tokenType;
    int expiresIn;
    String refreshToken;
    int createdAt;
    User user;

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
    int id;
    String email;
    DateTime createdAt;
    DateTime updatedAt;
    int employeeId;
    String role;
    String mobileNumber;

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
