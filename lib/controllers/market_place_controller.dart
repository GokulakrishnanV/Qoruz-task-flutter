import 'package:flutter/material.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/services/market_place_service.dart';
import 'package:qoruz/utils/constants/strings.dart';
import 'package:qoruz/utils/handlers/api_response.dart';
import 'package:qoruz/utils/handlers/app_exceptions.dart';

class MarketPlaceController extends ChangeNotifier {

  int _selectedPage = 1;
  int get selectedPage => _selectedPage;
  void setSelectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }

  int _selectedQuickFilter = 0;
  int get selectedQuickFilter => _selectedQuickFilter;
  void setSelectedQuickFilter(int index) {
    _selectedQuickFilter = index;
    notifyListeners();
  }

  // API Data
  final _service = MarketPlaceService();

  // For [GET] APIs that return data
  ApiResponse<MarketPlaceList> _marketPlaceList = ApiResponse.initial(AppStrings.initial);
  ApiResponse<MarketPlaceList> get marketPlaceList => _marketPlaceList;

  ApiResponse<MarketplaceRequest> _marketPlaceDetail = ApiResponse.initial(AppStrings.initial);
  ApiResponse<MarketplaceRequest> get marketPlaceDetail => _marketPlaceDetail;

  Future<ApiResponse<MarketPlaceList>> getMarketPlaceList({required String page}) async {
    _marketPlaceList = ApiResponse.loading('Fetching MarketPlace List');
    notifyListeners();
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

  Future<ApiResponse<MarketplaceRequest>> getMarketPlaceDetails({required String idHash}) async {
    _marketPlaceDetail = ApiResponse.loading('Fetching MarketPlace Details');
    notifyListeners();
    try {
      final response = await _service.getMarketPlaceDetails(idHash: idHash);
      final data = MarketplaceRequest.fromJson(response['web_marketplace_requests']);
      _marketPlaceDetail = ApiResponse.completed(data);
    } on AppException catch (e) {
      _marketPlaceDetail = ApiResponse.error(e.toString());
    }
    notifyListeners();
    return _marketPlaceDetail;
  }
}
