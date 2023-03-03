import 'package:qr_code_task/domain/entities/scan_info.dart';

class ScanInfoModel extends ScanInfo {
  ScanInfoModel({
    super.status,
    super.message,
    super.id,
    super.scannerId,
    super.code,
  });

  factory ScanInfoModel.fromJson(Map<String, dynamic> json) => ScanInfoModel(
        id: json['id'] ?? -1,
        scannerId: json['scanner_id'] ?? '',
        code: json['code'] ?? '',
      );
}
