import 'package:dio/dio.dart';
import 'package:qoruz/routes/api_routes.dart';
import 'package:qoruz/utils/constants/keys.dart';
import 'package:qoruz/utils/handlers/exception_handler.dart';

class MarketPlaceService {
  Future<Map<String, dynamic>> getMarketPlaceList({required String page}) async {
    try {
      final response = await dio.get(ApiRoutes.marketPlaceList, queryParameters: {AppKeys.page: page});
      return response.data;
    } on DioException catch (e) {
      throw ExceptionHandler.handleApiException(e);
    }
  }

  Future<Map<String, dynamic>> getMarketPlaceDetails({required String idHash}) async {
    try {
      final response = await dio.get(ApiRoutes.marketPlaceList, queryParameters: {AppKeys.idHash: idHash});
      return response.data;
    } on DioException catch (e) {
      throw ExceptionHandler.handleApiException(e);
    }
  }
}
