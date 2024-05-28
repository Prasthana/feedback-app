
import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oneononesresponse.g.dart';

@JsonSerializable()
class OneOnOnesResponse {
  
    @JsonKey(name: 'one_on_ones')
    List<OneOnOne>? oneononesList;

    OneOnOnesResponse({
        this.oneononesList,
    });

  factory OneOnOnesResponse.fromJson(Map<String, dynamic> json) =>
      _$OneOnOnesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOnesResponseToJson(this);

}