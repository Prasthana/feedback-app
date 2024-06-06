
import 'package:feedbackapp/api_services/models/one_on_one_point.dart';



class PointResponse {
    OneOnOnePoint oneOnOnePoint;

    PointResponse({
        required this.oneOnOnePoint,
    });

    factory PointResponse.fromJson(Map<String, dynamic> json) => PointResponse(
        oneOnOnePoint: OneOnOnePoint.fromJson(json["one_on_one_point"]),
    );

    Map<String, dynamic> toJson() => {
        "one_on_one_point": oneOnOnePoint.toJson(),
    };
}