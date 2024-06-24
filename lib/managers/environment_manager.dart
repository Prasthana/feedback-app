import 'package:oneononetalks/screens/login/environment_setting_view.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class EnvironmentManager {
  static Environment currentEnv = Environment(id:0, baseUrl: "", clientId: "", clientScret: "");
  static bool? isProdEnv;

   static final List<Environment> environments = [
    Environment(
        id: 1,
        name: constants.stagingText,
        baseUrl: constants.stagingBaseUrl,
        clientId: constants.stagingClientId,
        clientScret: constants.stagingClientSecret),
    Environment(
        id: 2,
        name:constants.productionText,
        baseUrl: constants.productionBaseUrl,
        clientId: constants.productionClientId,
        clientScret: constants.productionClientSecret)
  ];
}
