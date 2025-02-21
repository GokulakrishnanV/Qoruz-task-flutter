import 'package:dio/dio.dart' show BaseOptions, Dio;

final BaseOptions options = BaseOptions(baseUrl: const String.fromEnvironment('SERVER_URL'), contentType: 'application/json');

final Dio dio = Dio(options);

class ApiRoutes {
  static const String marketPlaceList = '/api/v1/interview.mplist';
}
