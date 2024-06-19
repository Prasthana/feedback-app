
import 'package:oneononetalks/api_services/api_client.dart';
import 'package:oneononetalks/api_services/dio-addOns/dio_client.dart';



class ApiManager {

  // staging credentials
  static const String baseURL =
      'http://feedback-staging-alb-818086335.us-east-2.elb.amazonaws.com/';

  // Production credentials
  // static const String baseURL =
  //     'http://feedback-production-alb-314267296.us-east-2.elb.amazonaws.com/';

  static final authenticated = ApiClient(buildDioClient(baseURL));
  static final public = ApiClient(buildDioClient(baseURL));
}
