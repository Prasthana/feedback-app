import 'package:json_annotation/json_annotation.dart';

part 'emailotp.g.dart';

@JsonSerializable()
class EmailOTPRequest {
  String email;
  String deviceType;

  EmailOTPRequest({
    required this.email,
    required this.deviceType,
  });

  factory EmailOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailOTPRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EmailOTPRequestToJson(this);
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

@JsonSerializable()
class EmailOTPResponse {
  int id;
  String email;

  EmailOTPResponse({required this.id, required this.email});

  factory EmailOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailOTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmailOTPResponseToJson(this);
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########


