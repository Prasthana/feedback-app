// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'oneonones.g.dart';

// List<OneOnOne> welcomeFromJson(String str) =>
//     List<OneOnOne>.from(json.decode(str).map((x) => OneOnOne.fromJson(x)));

// String welcomeToJson(List<OneOnOne> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class OneOnOne {
  int id;
  DateTime scheduledDate;
  DateTime? startTime;
  DateTime? endTime;
  String status;
  dynamic notes;
  Participant participant;

  OneOnOne({
    required this.id,
    required this.scheduledDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.notes,
    required this.participant,
  });

  factory OneOnOne.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOneToJson(this);
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########

@JsonSerializable()
class Participant {
  int id;
  String name;
  String email;

  Participant({
    required this.id,
    required this.name,
    required this.email,
  });
 
  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}

// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
// ########----########----########----########----########----########----########----########----########----########
