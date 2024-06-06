
import 'package:oneononetalks/api_services/models/one_on_one_point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pointResponse.g.dart';

@JsonSerializable()
class PointResponse {
   @JsonKey(name: 'one_on_one_point')
    OneOnOnePoint oneOnOnePoint;

    PointResponse({
        required this.oneOnOnePoint,
    });

  factory PointResponse.fromJson(Map<String, dynamic> json) =>
      _$PointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PointResponseToJson(this);
}