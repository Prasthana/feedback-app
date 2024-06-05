import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_request.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

part 'oneonone.g.dart';

@JsonSerializable(includeIfNull: false)
class OneOnOne {
  int? id;
  @JsonKey(name: 'start_date_time')
  String? startDateTime;
  @JsonKey(name: 'end_date_time')
  String? endDateTime;
  String? status;
  String? notes;
  @JsonKey(name: 'feedback_rating')
  double? feedbackRating;

  @JsonKey(name: 'good_at_points')
  List<Point>? goodAtPoints;

  @JsonKey(name: 'yet_to_improve_points')
  List<Point>? yetToImprovePoints;

  @JsonKey(name: 'one_on_one_participants')
  List<OneOnOneParticipant>? oneOnOneParticipants;

  @JsonKey(name: 'one_on_one_participants_attributes')
  List<OneOnOneParticipantsAttribute>? oneOnOneParticipantsAttributes;

  @JsonKey(name: 'one_on_one_points_attributes')
  List<OneOnOnePointsAttribute>? oneOnOnePointsAttributes;

  OneOnOne({
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.status,
    this.notes,
    this.feedbackRating,
    this.goodAtPoints,
    this.yetToImprovePoints,
    this.oneOnOneParticipants,
    this.oneOnOneParticipantsAttributes,
    this.oneOnOnePointsAttributes,
  });

  factory OneOnOne.fromJson(Map<String, dynamic> json) =>
      _$OneOnOneFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOneToJson(this);
}

@JsonSerializable(includeIfNull: false)
class OneOnOnePointsAttribute {
  int? id;
  @JsonKey(name: 'point_type')
  String pointType;
  String? title;
  @JsonKey(name: 'mark_as_done')
  bool? markAsDone;

  OneOnOnePointsAttribute(
      {this.id, required this.pointType, this.title, this.markAsDone});

  factory OneOnOnePointsAttribute.fromJson(Map<String, dynamic> json) =>
      _$OneOnOnePointsAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOnePointsAttributeToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Point {
  int? id;
  dynamic completionComment;
  String title;
  @JsonKey(name: 'mark_as_done')
  bool? markAsDone;

  Point({
    this.id,
    this.completionComment,
    required this.title,
    this.markAsDone,
  });

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);
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

extension OneOnOneExtension on OneOnOne {
  Employee? getOpponentUser(int loginUserId) {
    var oneOnOneParticipantsList = oneOnOneParticipants ?? [];
    OneOnOneParticipant opponentParticipant = oneOnOneParticipantsList
        .firstWhere((item) => item.employee.id != loginUserId);
        debugPrint("employee name ----->>> ${opponentParticipant.employee.name}");
    return opponentParticipant.employee;
  }
}
