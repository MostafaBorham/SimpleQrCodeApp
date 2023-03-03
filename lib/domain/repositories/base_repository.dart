import 'package:dartz/dartz.dart';
import 'package:qr_code_task/core/app_errors/failures.dart';
import 'package:qr_code_task/domain/entities/scan_info.dart';
import 'package:qr_code_task/domain/entities/user.dart';

abstract class BaseRepository {
  Future<Either<Failure, User>> login({String? email, String? password});
  Future<Either<Failure, List<ScanInfo>>> getScans();
  Future<Either<Failure, void>> scan({String? code});
}
