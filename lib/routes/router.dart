import 'package:go_router/go_router.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/routes/app_routes.dart';
import 'package:qoruz/views/market_place.dart';
import 'package:qoruz/views/market_place_detail.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/marketplace',
    routes: [
      GoRoute(
        path: '/marketplace',
        name: AppRoutes.marketplace,
        builder: (context, state) => MarketPlaceScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            name: AppRoutes.marketplaceDetail,
            builder: (context, state) => MarketPlaceDetailScreen(marketplaceRequest: state.extra as MarketplaceRequest),
          ),
        ],
      ),
    ],
  );
}
