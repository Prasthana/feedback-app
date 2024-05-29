import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'one_on_one_create_request.g.dart';

//OneOnOneCreateRequest oneOnOneCreateRequestFromJson(String str) => OneOnOneCreateRequest.fromJson(json.decode(str));
//String oneOnOneCreateRequestToJson(OneOnOneCreateRequest data) => json.encode(data.toJson());

@JsonSerializable()
class OneOnOneCreateRequest {
    @JsonKey(name: 'one_on_one')
    OneOnOneCreate oneOnOne;

    OneOnOneCreateRequest({
        required this.oneOnOne,
    });

  factory OneOnOneCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOneCreateRequestToJson(this);
}

/*
@JsonSerializable()
class OneOnOne {
    @JsonKey(name: 'start_date_time')
    String startDateTime;
    @JsonKey(name: 'end_date_time')
    String endDateTime;
    String notes;
    @JsonKey(name: 'one_on_one_participants_attribute')
    List<OneOnOneParticipantsAttribute> oneOnOneParticipantsAttributes;

    OneOnOne({
        required this.startDateTime,
        required this.endDateTime,
        required this.notes,
        required this.oneOnOneParticipantsAttributes,
    });

    factory OneOnOne.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneToJson(this);
}
*/

@JsonSerializable()
class OneOnOneParticipantsAttribute {
    @JsonKey(name: 'employee_id')
    int employeeId;

    OneOnOneParticipantsAttribute({
        required this.employeeId,
    });

    factory OneOnOneParticipantsAttribute.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneParticipantsAttributeFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneParticipantsAttributeToJson(this);
}