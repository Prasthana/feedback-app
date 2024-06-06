import 'package:oneononetalks/api_services/models/userlogin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifyotp.g.dart';

@JsonSerializable()
class VerifyEmailOTPRequest {
  int id;
  @JsonKey(name: 'email_auth_code')
  String emailAuthCode;

  VerifyEmailOTPRequest({required this.id, 
                          required this.emailAuthCode, 
                          });

  factory VerifyEmailOTPRequest.fromJson(Map<String, dynamic> json) => _$VerifyEmailOTPRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailOTPRequestToJson(this);

}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


@JsonSerializable()
class VerifyEmailOTPResponse {
  @JsonKey(name: 'user_login')
    UserLogin? userLogin;

    VerifyEmailOTPResponse({
        this.userLogin,
    });

   factory VerifyEmailOTPResponse.fromJson(Map<String, dynamic> json) => _$VerifyEmailOTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailOTPResponseToJson(this);

}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


