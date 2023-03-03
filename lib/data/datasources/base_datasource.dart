import 'package:qr_code_task/data/models/scan_info_model.dart';
import 'package:qr_code_task/data/models/user_model.dart';

abstract class BaseDataSource {
  Future<UserModel> login({String? email, String? password});
  Future<List<ScanInfoModel>> getScans();
  Future<void> scan({String? code});
}
