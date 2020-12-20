import 'package:flutter_task_app/src/config/app_config.dart';

class ApiServiceUrls {
  static String baseURL = AppConfig.baseURL;
  static String signup = baseURL + 'signup';
  static String login = baseURL + 'login';
  static String forgotPassword = baseURL + 'forgot_password';
  static String languages = baseURL + 'languages';
}
