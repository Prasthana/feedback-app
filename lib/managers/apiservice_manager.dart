
import 'package:dio/dio.dart';
import 'package:oneononetalks/api_services/api_client.dart';
import 'package:oneononetalks/api_services/dio-addOns/dio_client.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class ApiManager {
  static String baseURL = EnvironmentManager.currentEnv.baseUrl;
  static final authenticated = ApiClient(buildDioClient(baseURL));
  static final public = ApiClient(buildDioClient(baseURL));
}
