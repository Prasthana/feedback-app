
import 'package:json_annotation/json_annotation.dart';
part 'pointRequest.g.dart';

@JsonSerializable()
class PointRequest {
   @JsonKey(name: 'one_on_one_point')
    OneOnOnePoint oneOnOnePoint;

    PointRequest({
        required this.oneOnOnePoint,
    });

  factory PointRequest.fromJson(Map<String, dynamic> json) =>
      _$PointRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PointRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class OneOnOnePoint {
    int? id;
    @JsonKey(name: 'completion_comment')
    dynamic completionComment;
    String? title;
    @JsonKey(name: 'mark_as_done')
    bool? markAsDone;

    OneOnOnePoint({
        this.id,
        this.completionComment,
        this.title,
        this.markAsDone,
    });

   factory OneOnOnePoint.fromJson(Map<String, dynamic> json) =>
      _$OneOnOnePointFromJson(json);
  Map<String, dynamic> toJson() => _$OneOnOnePointToJson(this);
}