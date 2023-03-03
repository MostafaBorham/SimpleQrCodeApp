import 'package:dartz/dartz.dart';
import 'package:qr_code_task/core/app_errors/failures.dart';
import 'package:qr_code_task/domain/repositories/base_repository.dart';

class ScanUseCase {
  final BaseRepository? baseRepo;

  ScanUseCase({this.baseRepo});

  Future<Either<Failure, void>> call({String? code}) async =>
      await baseRepo!.scan(code: code);
}
