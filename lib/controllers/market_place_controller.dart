import 'package:flutter/material.dart';
import 'package:qoruz/models/market_place_detail_model.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/services/market_place_service.dart';
import 'package:qoruz/utils/constants/strings.dart';
import 'package:qoruz/utils/handlers/api_response.dart';
import 'package:qoruz/utils/handlers/app_exceptions.dart';

class MarketPlaceController extends ChangeNotifier {
  // API Data
  final _service = MarketPlaceService();

  // For [GET] APIs that return data
  ApiResponse<MarketPlaceList> _marketPlaceList = ApiResponse.initial(AppStrings.initial);
  ApiResponse<MarketPlaceList> get marketPlaceList => _marketPlaceList;

  ApiResponse<MarketPlaceDetail> _marketPlaceDetail = ApiResponse.initial(AppStrings.initial);
  ApiResponse<MarketPlaceDetail> get marketPlaceDetail => _marketPlaceDetail;

  Future<ApiResponse<MarketPlaceList>> getMarketPlaceList({required String page}) async {
    _marketPlaceList = ApiResponse.loading('Fetching MarketPlace List');

    try {
      final response = await _service.getMarketPlaceList(page: page);
      final data = MarketPlaceList.fromJson(response);
      _marketPlaceList = ApiResponse.completed(data);
    } on AppException catch (e) {
      _marketPlaceList = ApiResponse.error(e.toString());
    }

    notifyListeners();
    return _marketPlaceList;
  }

  Future<ApiResponse<MarketPlaceDetail>> getMarketPlaceDetails({required String idHash}) async {
    _marketPlaceDetail = ApiResponse.loading('Fetching MarketPlace Details');

    try {
      final response = await _service.getMarketPlaceDetails(idHash: idHash);
      final data = MarketPlaceDetail.fromJson(response);
      _marketPlaceDetail = ApiResponse.completed(data);
    } on AppException catch (e) {
      _marketPlaceDetail = ApiResponse.error(e.toString());
    }
    notifyListeners();
    return _marketPlaceDetail;
  }
}
