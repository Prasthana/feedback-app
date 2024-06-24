import 'package:oneononetalks/screens/login/environment_setting_view.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class EnvironmentManager {
  static Environment currentEnv = environments.first;

   static final List<Environment> environments = [
    Environment(
        id: 1,
        name: "Staging",
        baseUrl: constants.stagingBaseUrl,
        clientId: constants.stagingClientId,
        clientScret: constants.stagingClientSecret),
    Environment(
        id: 2,
        name: "Production",
        baseUrl: constants.productionBaseUrl,
        clientId: constants.productionClientId,
        clientScret: constants.productionClientSecret)
  ];
}
