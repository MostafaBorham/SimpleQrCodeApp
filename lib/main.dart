import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_task/core/app_network/dio_helper.dart';
import 'package:qr_code_task/core/app_resources/app_strings.dart';
import 'package:qr_code_task/core/app_routes/router.dart';
import 'package:qr_code_task/core/app_routes/routes.dart';
import 'package:qr_code_task/core/app_services/dependency_injector.dart';
import 'package:qr_code_task/presentaion/managers/auth_cubit/auth_cubit.dart';
import 'package:qr_code_task/presentaion/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentaion/managers/scan_cubit/scan_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.init();
  DioHelper.init();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const QrCodeApp()));
}

class QrCodeApp extends StatelessWidget {
  const QrCodeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => DependencyInjector.dihInstance<AuthCubit>()),
        BlocProvider(
            create: (_) => DependencyInjector.dihInstance<ScanCubit>()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.loginScreenRoute,
      ),
    );
  }
}
