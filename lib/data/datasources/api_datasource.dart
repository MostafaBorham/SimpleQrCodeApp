import 'package:flutter/cupertino.dart';
import 'package:qr_code_task/core/app_connection/connection_checker.dart';
import 'package:qr_code_task/core/app_errors/errors.dart';
import 'package:qr_code_task/core/app_errors/exception.dart';
import 'package:qr_code_task/core/app_network/constants.dart';
import 'package:qr_code_task/core/app_network/dio_helper.dart';
import 'package:qr_code_task/data/datasources/base_datasource.dart';
import 'package:qr_code_task/data/models/scan_info_model.dart';
import 'package:qr_code_task/data/models/user_model.dart';

class ApiDataSource extends BaseDataSource {
  @override
  Future<UserModel> login({String? email, String? password}) async {
    if (await ConnectionChecker.isConnected) {
      final response = await DioHelper.postData(
          endPoint: NetworkConstants.loginEndpoint,
          body: {
            NetworkConstants.emailKey: email,
            NetworkConstants.passwordKey: password,
          });
      debugPrint(
          'responseData= ${response.data} - responseStatusCode= ${response.statusCode}');
      if (response.data[NetworkConstants.responseStatusKey] ==
          NetworkConstants.successStatusValue) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException(
            errorMessage: response.data[NetworkConstants.responseMessageKey]);
      }
    } else {
      throw OfflineException(errorMessage: AppErrors.offlineErrorMessage);
    }
  }

  @override
  Future<List<ScanInfoModel>> getScans() async {
    if (await ConnectionChecker.isConnected) {
      final response =
          await DioHelper.getData(endPoint: NetworkConstants.myScansEndpoint);
      debugPrint(
          'responseData= ${response.data} - responseStatusCode= ${response.statusCode}');
      if (response.data[NetworkConstants.responseStatusKey] ==
          NetworkConstants.successStatusValue) {
        return List<ScanInfoModel>.from(response.data['data']
            .map<ScanInfoModel>(
                (scanInfoJson) => ScanInfoModel.fromJson(scanInfoJson)));
      } else {
        throw ServerException(
            errorMessage: response.data[NetworkConstants.responseMessageKey]);
      }
    } else {
      throw OfflineException(errorMessage: AppErrors.offlineErrorMessage);
    }
  }

  @override
  Future<void> scan({String? code}) async {
    if (await ConnectionChecker.isConnected) {
      final response = await DioHelper.postData(
          endPoint: NetworkConstants.scanEndpoint,
          body: {
            NetworkConstants.codeKey: code,
          });
      debugPrint(
          'responseData= ${response.data} - responseStatusCode= ${response.statusCode}');
      if (response.data[NetworkConstants.responseStatusKey] ==
          NetworkConstants.successStatusValue) {
        return;
      } else {
        throw ServerException(
            errorMessage: response.data[NetworkConstants.responseMessageKey]);
      }
    } else {
      throw OfflineException(errorMessage: AppErrors.offlineErrorMessage);
    }
  }
}
