import 'package:equatable/equatable.dart';
import 'package:qr_code_task/domain/entities/response.dart';

class ScanInfo extends Response implements Equatable {
  final int? id;
  final String? code, scannerId;

  ScanInfo({
    int? status,
    String? message,
    this.id,
    this.code,
    this.scannerId,
  }) : super(status: status, message: message);
  @override
  List<Object?> get props => [
        status,
        message,
        id,
        scannerId,
        code,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
