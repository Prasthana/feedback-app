
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oneonone.g.dart';

@JsonSerializable(includeIfNull: false)
class OneOnOne {
    int? id;
    @JsonKey(name: 'start_date_time')
    String startDateTime;
    @JsonKey(name: 'end_date_time')
    
    String endDateTime;
    String? status;
    String notes;

    @JsonKey(name: 'good_at_points')
    List<dynamic>? goodAtPoints;

    @JsonKey(name: 'yet_to_improve_points')
    List<dynamic>? yetToImprovePoints;

    @JsonKey(name: 'one_on_one_participants')
    List<OneOnOneParticipant>? oneOnOneParticipants;

    @JsonKey(name: 'one_on_one_participants_attributes')
    List<OneOnOneParticipantsAttribute>? oneOnOneParticipantsAttributes;

    OneOnOne({
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

    factory OneOnOne.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOneToJson(this);
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

  get name => null;
    Map<String, dynamic> toJson() => _$OneOnOneParticipantToJson(this);
}
