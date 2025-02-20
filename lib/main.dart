import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qoruz/controllers/market_place_controller.dart';
import 'package:qoruz/routes/router.dart';
import 'package:qoruz/utils/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MarketPlaceController())],
      child: MaterialApp.router(
        title: 'Qoruz Marketplace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: GenericColors.white,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
