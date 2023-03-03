abstract class NetworkConstants {
  static const String baseUrl = 'https://fourthpyramidagcy.net/company/api/v1';
  static const String loginEndpoint = '/login';
  static const String myScansEndpoint = '/history';
  static const String scanEndpoint = '/scan';
  static const String acceptHeaderKey = "Accept";
  static const String acceptHeaderValue = "application/json";
  static const String authorizationKey = "Authorization";
  static const String bearerAuthorizationValue = "Bearer";
  static const String emailKey = "email";
  static const String codeKey = "code";
  static const String passwordKey = "password";
  static const String responseStatusKey = 'status';
  static const String responseMessageKey = 'massage';
  static const int successStatusValue = 1;
  static const int failStatusValue = 0;
  static String? userToken;
}
