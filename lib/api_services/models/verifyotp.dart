import 'package:json_annotation/json_annotation.dart';

part 'verifyotp.g.dart';

@JsonSerializable()
class VerifyEmailOTPRequest {
  int id;
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
  int id;
  String loginToken;
  String email;

  VerifyEmailOTPResponse({required this.id,
                    required this.loginToken,
                    required this.email
                   });

   factory VerifyEmailOTPResponse.fromJson(Map<String, dynamic> json) => _$VerifyEmailOTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailOTPResponseToJson(this);

}


// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


