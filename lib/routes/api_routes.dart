import 'package:dio/dio.dart' show BaseOptions, Dio;

BaseOptions options = BaseOptions(baseUrl: const String.fromEnvironment('SERVER_URL'), contentType: 'application/json');

Dio dio = Dio(options);

class ApiRoutes {
  static const String marketPlaceList = '/api/v1/interview.mplist';
}
