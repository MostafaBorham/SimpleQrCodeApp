import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qr_code_task/core/app_network/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    ///solution for HandshakeException
    HttpOverrides.global = MyHttpOverrides();
    dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: NetworkConstants.baseUrl,
        contentType: ContentType.json.toString(),
        responseType: ResponseType.json,
        headers: {
          NetworkConstants.acceptHeaderKey: NetworkConstants.acceptHeaderValue,
          NetworkConstants.authorizationKey:
              "${NetworkConstants.bearerAuthorizationValue} ${NetworkConstants.userToken}",
        }));
  }

  static reInit() {
    ///to refresh bearer token
    dio!.options.headers.update(
        NetworkConstants.authorizationKey,
        (value) =>
            "${NetworkConstants.bearerAuthorizationValue} ${NetworkConstants.userToken}");
  }

  static Future<Response> getData(
      {String? endPoint, Map<String, dynamic>? body}) async {
    return await dio!.get(
      endPoint!,
      data: body,
    );
  }

  static Future<Response> postData(
      {String? endPoint, Map<String, dynamic>? body}) async {
    return await dio!.post(endPoint!, data: body);
  }
}

/// Http Class Security for solve Handshake Exception problem
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
