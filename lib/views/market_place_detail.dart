import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/utils/constants/colors.dart';
import 'package:qoruz/utils/constants/image_constants.dart';
import 'package:qoruz/views/widgets/custom_image_container.dart';
import 'package:vector_graphics/vector_graphics.dart';

class MarketPlaceDetailScreen extends StatefulWidget {
  const MarketPlaceDetailScreen({super.key, required this.marketplaceRequest});

  final MarketplaceRequest marketplaceRequest;

  @override
  State<MarketPlaceDetailScreen> createState() => _MarketPlaceDetailScreenState();
}

class _MarketPlaceDetailScreenState extends State<MarketPlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GenericColors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        actions: [
          IconButton(icon: const Icon(Symbols.delete), color: AppColors.primary, onPressed: () {}),
          Container(
            height: 28.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [GenericColors.deepOrange, GenericColors.pink]),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.share_outlined, color: GenericColors.white, size: 16.0),
          ),
          SizedBox(width: 16.0),
        ],
        shape: Border(bottom: BorderSide(color: GenericColors.lavenderGrey, width: 1.0)),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            color: GenericColors.ghostWhite,
            child: Row(
              children: [
                NetworkImageContainer(
                  height: 40.0,
                  width: 40.0,
                  borderRadius: 25.0,
                  imageUrl: 'https://www.environmentcontrol.com/asset/601c9a3b2c9ec?w=800&fit=max',
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Angel Rosser', style: TextStyle(color: AppColors.textDark, fontSize: 12.0, fontWeight: FontWeight.w600)),
                          SizedBox(width: 5.0),
                          Image.asset(AppIcons.linkedin, height: 12.0, width: 12.0),
                          SizedBox(width: 5.0),
                          SvgPicture(AssetBytesLoader(AppIcons.verified), height: 12.0, width: 12.0),
                          Spacer(),
                          Text('1h', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0)),
                        ],
                      ),
                      Text('Senior Sales Manager ', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0)),
                      Wrap(direction: Axis.horizontal, children: [Icon(Icons.corporate_fare_rounded, color: AppColors.textSecondary, size: 14.0)]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
