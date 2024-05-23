
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VerifyEmailOTPRequest {
  int id;
  String emailAuthCode;

  VerifyEmailOTPRequest({required this.id, 
                          required this.emailAuthCode, 
                          });

  factory VerifyEmailOTPRequest.fromJson(Map<String, dynamic> json) => VerifyEmailOTPRequest(
    id: json["id"],
    emailAuthCode: json["email_auth_code"],
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "email_auth_code": emailAuthCode,
  };
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

@JsonSerializable()
class VerifyEmailOTPResponse {
  int id;
  String loginToken;
  String email;

  VerifyEmailOTPResponse({required this.id,
                    required this.loginToken,
                    required this.email
                   });

  factory VerifyEmailOTPResponse.fromJson(Map<String, dynamic> json) => VerifyEmailOTPResponse(
    id: json["id"],
    loginToken: json["login_token"],
    email: json["email"]
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "login_token": loginToken,
    "email": email
  };
}


// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


