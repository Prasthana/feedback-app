
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_request.dart';
import 'package:json_annotation/json_annotation.dart';
part 'one_on_one_create_response.g.dart';

//OneOnOneCreateResponse oneOnOneCreateResponseFromJson(String str) => OneOnOneCreateResponse.fromJson(json.decode(str));
//String oneOnOneCreateResponseToJson(OneOnOneCreateResponse data) => json.encode(data.toJson());

@JsonSerializable()
class OneOnOneCreateResponse {
    @JsonKey(name: 'one_on_one')
    OneOnOneCreate oneOnOne;

    OneOnOneCreateResponse({
        required this.oneOnOne,
    });

    factory OneOnOneCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneCreateResponseFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneCreateResponseToJson(this);
}

@JsonSerializable()
class OneOnOneCreate {
    @JsonKey(includeIfNull: false)
    int? id;
    @JsonKey(name: 'start_date_time')
    String startDateTime;
    @JsonKey(name: 'end_date_time')
    
    String endDateTime;
    @JsonKey(includeIfNull: false)
    String? status;
    String notes;

    @JsonKey(name: 'good_at_points', includeIfNull: false)
    List<dynamic>? goodAtPoints;

    @JsonKey(name: 'yet_to_improve_points', includeIfNull: false)
    List<dynamic>? yetToImprovePoints;

    @JsonKey(name: 'one_on_one_participants', includeIfNull: false)
    List<OneOnOneParticipant>? oneOnOneParticipants;

    @JsonKey(name: 'one_on_one_participants_attribute', includeIfNull: false)
    List<OneOnOneParticipantsAttribute>? oneOnOneParticipantsAttributes;

    OneOnOneCreate({
         this.id,
        required this.startDateTime,
        required this.endDateTime,
         this.status,
        required this.notes,
         this.goodAtPoints,
         this.yetToImprovePoints,
         this.oneOnOneParticipants,
         this.oneOnOneParticipantsAttributes,
    });

    factory OneOnOneCreate.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneCreateFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneCreateToJson(this);
}

@JsonSerializable()
class OneOnOneParticipant {
    int id;
    Employee employee;

    OneOnOneParticipant({
        required this.id,
        required this.employee,
    });

    factory OneOnOneParticipant.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneParticipantFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneParticipantToJson(this);
}
