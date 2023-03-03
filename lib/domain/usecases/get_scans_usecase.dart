import 'package:dartz/dartz.dart';
import 'package:qr_code_task/core/app_errors/failures.dart';
import 'package:qr_code_task/domain/entities/scan_info.dart';
import 'package:qr_code_task/domain/repositories/base_repository.dart';

class GetScansUseCase {
  final BaseRepository? baseRepo;

  GetScansUseCase({this.baseRepo});

  Future<Either<Failure, List<ScanInfo>>> call() async =>
      await baseRepo!.getScans();
}
