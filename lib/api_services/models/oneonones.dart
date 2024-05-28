import 'package:json_annotation/json_annotation.dart';

part 'oneonones.g.dart';

// List<OneOnOne> welcomeFromJson(String str) =>
//     List<OneOnOne>.from(json.decode(str).map((x) => OneOnOne.fromJson(x)));

// String welcomeToJson(List<OneOnOne> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class OneOnOne {
    @JsonKey(name: 'start_date_time')
    DateTime? startDateTime;
    @JsonKey(name: 'end_date_time')
    DateTime? endDateTime;
    String notes; // 
    @JsonKey(name: 'one_on_one_participants_attributes')
    List<OneOnOneParticipantsAttribute>? oneOnOneParticipantsAttributes;

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

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

@JsonSerializable()
class OneOnOneParticipantsAttribute {
    @JsonKey(name: 'employee_id')
    int? employeeId;

    OneOnOneParticipantsAttribute({
        required this.employeeId,
    });

      factory OneOnOneParticipantsAttribute.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneParticipantsAttributeFromJson(json);

      Map<String, dynamic> toJson() => _$OneOnOneParticipantsAttributeToJson(this);
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
