
import 'package:oneononetalks/api_services/api_client.dart';
import 'package:oneononetalks/api_services/dio-addOns/dio_client.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class ApiManager {
  static const String baseURL = constants.productionBaseUrl;
  //  constants.stagingBaseUrl
    // EnvironmentManager.currentEnv.baseUrl; nagaraju.kamatham@prasthana.com
  static final authenticated = ApiClient(buildDioClient(baseURL));
  static final public = ApiClient(buildDioClient(baseURL));
}
