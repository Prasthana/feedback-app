
import 'package:oneononetalks/api_services/api_client.dart';
import 'package:oneononetalks/api_services/dio-addOns/dio_client.dart';



class ApiManager {
  static const String baseURL =
      'http://ec2-18-219-231-99.us-east-2.compute.amazonaws.com/';

  static final authenticated = ApiClient(buildDioClient(baseURL));
  static final public = ApiClient(buildDioClient(baseURL));
}
