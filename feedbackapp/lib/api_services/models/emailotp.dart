
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EmailOTPRequest {
  String email;
  String deviceName;
  String deviceType;
  String mobileType;
  String deviceUId;

  EmailOTPRequest({required this.email, 
                          required this.deviceName, 
                          required this.deviceType, 
                          required this.mobileType,
                          required this.deviceUId,
                          });

  factory EmailOTPRequest.fromJson(Map<String, dynamic> json) => EmailOTPRequest(
    email: json["email"],
    deviceName: json["device_name"],
    deviceType: json["device_type"],
    mobileType: json["mobile_type"],
    deviceUId: json["device_uid"],
  );
  
  Map<String, dynamic> toJson() => {
    "email": email,
    "device_name": deviceName,
    "device_type": deviceType,
    "mobile_type": mobileType,
    "device_uid": deviceUId,
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


