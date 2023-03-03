import 'package:flutter/material.dart';
import 'package:qr_code_task/presentaion/screens/login_screen.dart';
import 'package:qr_code_task/presentaion/screens/scan_qr_code_screen.dart';
import 'package:qr_code_task/presentaion/screens/scan_results_screen.dart';

import 'routes.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginScreenRoute:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case AppRoutes.scanQrCodeScreenRoute:
      return MaterialPageRoute(builder: (_) => const ScanQrCodeScreen());
    case AppRoutes.scanResultsScreenRoute:
      return MaterialPageRoute(
          builder: (_) =>const ScanResultsScreen());
    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}
