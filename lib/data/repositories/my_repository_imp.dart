import 'package:dartz/dartz.dart';
import 'package:qr_code_task/core/app_errors/exception.dart';
import 'package:qr_code_task/core/app_errors/failures.dart';
import 'package:qr_code_task/data/datasources/base_datasource.dart';
import 'package:qr_code_task/domain/entities/scan_info.dart';
import 'package:qr_code_task/domain/entities/user.dart';
import 'package:qr_code_task/domain/repositories/base_repository.dart';

class BaseRepositoryImp extends BaseRepository {
  final BaseDataSource? dataSource;

  BaseRepositoryImp({this.dataSource});

  @override
  Future<Either<Failure, User>> login({String? email, String? password}) async {
    try {
      final result = await dataSource!.login(email: email, password: password);
      return Right(result);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(message: ex.errorMessage));
      } else if (ex is OfflineException) {
        return Left(OfflineFailure(message: ex.errorMessage));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ScanInfo>>> getScans() async {
    try {
      final result = await dataSource!.getScans();
      return Right(result);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(message: ex.errorMessage));
      } else if (ex is OfflineException) {
        return Left(OfflineFailure(message: ex.errorMessage));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> scan({String? code}) async {
    try {
      final result = await dataSource!.scan(code: code);
      return Right(result);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(message: ex.errorMessage));
      } else if (ex is OfflineException) {
        return Left(OfflineFailure(message: ex.errorMessage));
      } else {
        return Left(Failure());
      }
    }
  }
}
