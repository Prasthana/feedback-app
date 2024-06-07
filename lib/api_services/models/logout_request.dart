
import 'package:json_annotation/json_annotation.dart';
part 'logout_request.g.dart';

@JsonSerializable(includeIfNull: false)
class LogoutRequest {
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;
  @JsonKey(name: 'token')
  String? loginToken;

  LogoutRequest({required this.clientId, 
                 required this.clientSecret, 
                 this.loginToken, 
                });

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => _$LogoutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);

}