
import 'package:json_annotation/json_annotation.dart';

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

  factory LoginTokenRequest.fromJson(Map<String, dynamic> json) => LoginTokenRequest(
    grantType: json["grant_type"],
    clientId: json["client_id"],
    clientSecret: json["client_secret"],
    loginToken: json["login_token"],
  );
  
  Map<String, dynamic> toJson() => {
    "grant_type": grantType,
    "client_id": clientId,
    "client_secret": clientSecret,
    "login_token": loginToken,
  };
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########



@JsonSerializable()

class LoginTokenResponse {
    String? accessToken;
    String? tokenType;
    int? expiresIn;
    String? refreshToken;
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

    factory LoginTokenResponse.fromJson(Map<String, dynamic> json) => LoginTokenResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        createdAt: json["created_at"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "created_at": createdAt,
        "user": user?.toJson(),
    };
}

@JsonSerializable()
class User {
    int? id;
    String? email;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? employeeId;
    String? role;
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        employeeId: json["employee_id"],
        role: json["role"],
        mobileNumber: json["mobile_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_id": employeeId,
        "role": role,
        "mobile_number": mobileNumber,
    };
}



// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

