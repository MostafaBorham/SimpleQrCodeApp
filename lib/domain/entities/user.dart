import 'package:equatable/equatable.dart';
import 'package:qr_code_task/domain/entities/response.dart';

class User extends Response implements Equatable {
  final int? id;
  final String? email, token, name, address, phone, job, img, salary;

  User(
      {int? status,
      String? message,
      this.id,
      this.email,
      this.token,
      this.name,
      this.address,
      this.phone,
      this.job,
      this.img,
      this.salary})
      : super(status: status, message: message);

  @override
  List<Object?> get props => [
        email,
        status,
        message,
        token,
        name,
        address,
        phone,
        job,
        img,
        salary,
        id,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
