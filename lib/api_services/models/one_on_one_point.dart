
import 'package:json_annotation/json_annotation.dart';

part 'one_on_one_point.g.dart';

@JsonSerializable(includeIfNull: false)
class OneOnOnePoint {
    int? id;
    @JsonKey(name: 'created_at')
    String? createdAt;
    @JsonKey(name: 'updated_at')
    String? updatedAt;
    @JsonKey(name: 'point_type')
    String? pointType;
    @JsonKey(name: 'completion_comment')
    String? completionComment;
    String? title;
    @JsonKey(name: 'one_on_one_id')
    String? oneOnOneId;
    @JsonKey(name: 'created_by')
    String? createdBy;
    @JsonKey(name: 'updated_by')
    String? updatedBy;
    
    OneOnOnePoint({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.pointType,
        this.completionComment,
        this.title,
        this.oneOnOneId,
        this.createdBy,
        this.updatedBy,
    });

    factory OneOnOnePoint.fromJson(Map<String, dynamic> json) =>
      _$OneOnOnePointFromJson(json);
    Map<String, dynamic> toJson() => _$OneOnOnePointToJson(this);
}