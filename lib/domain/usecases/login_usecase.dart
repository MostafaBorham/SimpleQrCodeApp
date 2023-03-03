import 'package:dartz/dartz.dart';
import 'package:qr_code_task/core/app_errors/failures.dart';
import 'package:qr_code_task/domain/entities/user.dart';
import 'package:qr_code_task/domain/repositories/base_repository.dart';

class LoginUseCase {
  final BaseRepository? baseRepo;

  LoginUseCase({this.baseRepo});

  Future<Either<Failure, User>> call({String? email, String? password}) async =>
      await baseRepo!.login(email: email, password: password);
}
