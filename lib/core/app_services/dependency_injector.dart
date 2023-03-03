import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qr_code_task/data/datasources/api_datasource.dart';
import 'package:qr_code_task/data/datasources/base_datasource.dart';
import 'package:qr_code_task/data/repositories/my_repository_imp.dart';
import 'package:qr_code_task/domain/repositories/base_repository.dart';
import 'package:qr_code_task/domain/usecases/get_scans_usecase.dart';
import 'package:qr_code_task/domain/usecases/login_usecase.dart';
import 'package:qr_code_task/domain/usecases/scan_usecase.dart';
import 'package:qr_code_task/presentaion/managers/auth_cubit/auth_cubit.dart';
import 'package:qr_code_task/presentaion/managers/scan_cubit/scan_cubit.dart';

abstract class DependencyInjector {
  static final dihInstance = GetIt.instance;

  static void init() {
    ///Network
    dihInstance.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());

    ///DataSources
    dihInstance.registerLazySingleton<BaseDataSource>(() => ApiDataSource());

    ///Repositories
    dihInstance.registerLazySingleton<BaseRepository>(
        () => BaseRepositoryImp(dataSource: dihInstance()));

    ///UseCases
    dihInstance.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(baseRepo: dihInstance()));
    dihInstance.registerLazySingleton<GetScansUseCase>(
        () => GetScansUseCase(baseRepo: dihInstance()));
    dihInstance.registerLazySingleton<ScanUseCase>(
        () => ScanUseCase(baseRepo: dihInstance()));

    ///Cubits
    dihInstance.registerLazySingleton<AuthCubit>(() => AuthCubit());
    dihInstance.registerLazySingleton<ScanCubit>(() => ScanCubit());
  }
}
