import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_task/core/app_services/dependency_injector.dart';
import 'package:qr_code_task/domain/entities/scan_info.dart';
import 'package:qr_code_task/domain/usecases/get_scans_usecase.dart';
import 'package:qr_code_task/domain/usecases/scan_usecase.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  final getScansUseCase = DependencyInjector.dihInstance<GetScansUseCase>();
  final scanUseCase = DependencyInjector.dihInstance<ScanUseCase>();
  static ScanCubit get(context) => BlocProvider.of<ScanCubit>(context);

  getScans() async {
    emit(GetScansLoadingState());
    final result = await getScansUseCase();
    result.fold(
        (failure) => emit(GetScansFailedState(message: failure.message)),
        (scanInfoData) => emit(GetScansSuccessState(scans: scanInfoData)));
  }

  scan({String? code}) async {
    emit(ScanLoadingState());
    final result = await scanUseCase(code: code);
    result.fold((failure) => emit(ScanFailedState(message: failure.message)),
        (_) => emit(ScanSuccessState()));
  }
}
