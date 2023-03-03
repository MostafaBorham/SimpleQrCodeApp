import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qr_code_task/core/app_services/dependency_injector.dart';

class ConnectionChecker {
  static Future<bool> get isConnected =>
      DependencyInjector.dihInstance<InternetConnectionChecker>().hasConnection;
}
