import 'package:feedbackapp/api_services/models/oneonone.dart';
import 'package:json_annotation/json_annotation.dart';

part 'one_on_ones_list_response.g.dart';

@JsonSerializable()
class OneOnOnesListResponse {
  
    @JsonKey(name: 'one_on_ones')
    List<OneOnOne>? oneononesList;

    OneOnOnesListResponse({
        this.oneononesList,
    });

  factory OneOnOnesListResponse.fromJson(Map<String, dynamic> json) =>
      _$OneOnOnesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOnesListResponseToJson(this);

}