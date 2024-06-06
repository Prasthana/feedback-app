
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:json_annotation/json_annotation.dart';
part 'one_on_one_create_response.g.dart';


@JsonSerializable()
class OneOnOneCreateResponse {
    @JsonKey(name: 'one_on_one')
    OneOnOne oneOnOne;

    OneOnOneCreateResponse({
        required this.oneOnOne,
    });

    factory OneOnOneCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneCreateResponseFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneCreateResponseToJson(this);
}
