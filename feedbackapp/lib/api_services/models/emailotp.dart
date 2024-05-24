
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EmailOTPRequest {
  String email;
  String deviceType;

  EmailOTPRequest({required this.email, 
                          required this.deviceType, 
                          });

  factory EmailOTPRequest.fromJson(Map<String, dynamic> json) => EmailOTPRequest(
    email: json["email"],
    deviceType: json["device_type"],
  );
  
  Map<String, dynamic> toJson() => {
    "email": email,
    "device_type": deviceType,
  };
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

@JsonSerializable()
class EmailOTPResponse {
  int id;
  String email;

  EmailOTPResponse({required this.id,
                    required this.email
                   });

  factory EmailOTPResponse.fromJson(Map<String, dynamic> json) => EmailOTPResponse(
    id: json["id"],
    email: json["email"]
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email
  };
}


// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


