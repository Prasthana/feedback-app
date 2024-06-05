



import 'package:feedbackapp/api_services/models/logintoken.dart';

class LocalStorageManager {
  static final LocalStorageManager shared = LocalStorageManager();

  late User? loginUser;
}