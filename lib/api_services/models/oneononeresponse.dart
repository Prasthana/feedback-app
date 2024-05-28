
import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oneononeresponse.g.dart';

@JsonSerializable()
class OneOnOneResponse {
  
    @JsonKey(name: 'one_on_one')
    OneOnOne oneonones;

    OneOnOneResponse({
        required this.oneonones,
    });

  factory OneOnOneResponse.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOneResponseToJson(this);

}