import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/utils/constants/colors.dart';
import 'package:qoruz/utils/constants/image_constants.dart';
import 'package:qoruz/utils/constants/theme/text_theme.dart';
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: GenericColors.white,
          boxShadow: [BoxShadow(color: Color(0xFF000000).withValues(alpha: 0.12), blurRadius: 8.0, offset: Offset(8, 0))],
        ),
        height: 108.0,
        child: Column(
          spacing: 8.0,
          children: [
            Row(
              spacing: 4.0,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [Color(0xFF3F51B5), Color(0xFF5C6CC1), Color(0xFF7887CC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.schedule_rounded, size: 14.0),
                ),
                Text('Your post will be expired on 14th July', style: AppTextStyles.b3r),
              ],
            ),
            Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.primary),
                      side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary)),
                    ),
                    child: Text('Edit', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.textLight),
                      backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                    ),
                    child: Text('Close', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                color: GenericColors.ghostWhite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(height: 2.0),
                          Text('Senior Sales Manager ', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0)),
                          SizedBox(height: 2.0),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 5.0,
                            children: [
                              Icon(Icons.corporate_fare, color: AppColors.textSecondary, size: 14.0),
                              Text('Meesho', style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Wrap(
                        runSpacing: 2.0,
                        direction: Axis.horizontal,
                        children: [
                          Text('Looking For', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0, height: 1.6)),
                          Row(
                            children: [
                              ShaderMask(
                                shaderCallback:
                                    (bounds) => LinearGradient(
                                      colors: widget.marketplaceRequest.colors ?? [],
                                      begin: widget.marketplaceRequest.begin!,
                                      end: widget.marketplaceRequest.end!,
                                    ).createShader(bounds),
                                blendMode: BlendMode.srcIn,
                                child: Icon(widget.marketplaceRequest.icon, size: 14.0),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${widget.marketplaceRequest.serviceType}',
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: AppColors.textDark),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: AppColors.border, thickness: 1.0),
                    Text('Highlights', style: TextStyle(color: AppColors.textTertiary, fontSize: 12.0, fontWeight: FontWeight.w700, height: 1.6)),
                    SizedBox(height: 4.0),
                    Wrap(
                      spacing: 8.07,
                      children: [
                        HighlightsContainer(text: 'Budget: 1,45,000', icon: Icons.currency_rupee_rounded),
                        HighlightsContainer(text: 'Brand: Swiggy', icon: Icons.campaign_outlined),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget: ₹1,50,000\nBrand: WanderFit Luggage\nLocation: Goa & Kerala\nType: Lifestyle & Adventure travel content with a focus on young, urban audiences\nLanguage: English and HindiLooking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. Content should emphasize ease of travel and durability of the product.',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16.0),
                Row(
                  // direction: Axis.horizontal,
                  // spacing: 8.0,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // alignment: WrapAlignment.center,
                  children: [
                    Expanded(
                      child: SocialsContainer(prefix: 'Share via', platform: 'WhatsApp', logo: AppIcons.whatsapp, color: GenericColors.neonGreen),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: SocialsContainer(
                        prefix: 'Share on',
                        platform: 'LinkedIn',
                        logo: AppIcons.linkedin,
                        color: GenericColors.brightRoyalBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Highlighted Details', style: AppTextStyles.t2sb),
                SizedBox(height: 12.0),
                LayoutGrid(
                  columnSizes: [1.fr, 1.fr],
                  rowSizes: [auto, auto, auto, auto],
                  rowGap: 16.0,
                  columnGap: 16.0,

                  children: [
                    HighlightedDetail(title: 'Category', value: 'Lifestyle, Fashion'),
                    HighlightedDetail(title: 'Platform', value: 'Instagram, Youtube'),
                    HighlightedDetail(title: 'Language', value: 'Hindi, Kannada, Malayalam, Tamil & Telugu'),
                    HighlightedDetail(title: 'Location', value: 'Bangalore, Tamilnadu, Kerala & GoaBangalore, Tamilnadu, Kerala & GoaBangalore'),
                    HighlightedDetail(title: 'Required Count', value: '15 - 20'),
                    HighlightedDetail(title: 'Our Budget', value: '₹1,45,000'),
                    HighlightedDetail(title: 'Brand Collab With', value: 'Swiggy'),
                    HighlightedDetail(
                      title: 'Required Followers',
                      child: Column(
                        spacing: 6.0,
                        children: [
                          SocialFollowersCount(icon: AppIcons.instagram, count: '10k - 15k+'),
                          SocialFollowersCount(icon: AppIcons.youtube, count: '10k - 15k+'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 150.0),
        ],
      ),
    );
  }
}

class SocialFollowersCount extends StatelessWidget {
  const SocialFollowersCount({super.key, required this.icon, required this.count});

  final String icon, count;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 2.0,
      children: [SvgPicture(AssetBytesLoader(icon), height: 14.0, width: 14.0), Text(count, style: AppTextStyles.labelR)],
    );
  }
}

class HighlightedDetail extends StatelessWidget {
  const HighlightedDetail({super.key, required this.title, this.value, this.child});

  final String title;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (value == null && child == null) {
      throw AssertionError('Either "value" or "child" must not be null');
    }
    return SizedBox(
      width: 142.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [HighlightDetailTitle(title: title), value != null ? Flexible(child: Text(value!, style: AppTextStyles.labelR)) : child!],
      ),
    );
  }
}

class HighlightDetailTitle extends StatelessWidget {
  const HighlightDetailTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: AppColors.textDark, fontSize: 12.0));
  }
}

class SocialsContainer extends StatelessWidget {
  const SocialsContainer({super.key, required this.prefix, required this.platform, required this.logo, required this.color});

  final String prefix, platform, logo;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8.0)),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        spacing: 4.0,
        children: [
          Image.asset(logo, height: 16.0, width: 16.0),
          RichText(
            text: TextSpan(
              text: prefix,
              style: TextStyle(color: AppColors.textDark, fontSize: 12.0),
              children: [TextSpan(text: ' $platform', style: TextStyle(fontWeight: FontWeight.w500))],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class HighlightsContainer extends StatelessWidget {
  const HighlightsContainer({super.key, this.isSvgIcon = false, this.svgIcon, this.icon, required this.text});
  final bool isSvgIcon;
  final String? svgIcon;
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (isSvgIcon && (svgIcon == null || svgIcon!.isEmpty)) {
      throw AssertionError('When "isSvgIcon" is true, "svgIcon" must not be null or empty');
    } else if (!isSvgIcon && icon == null) {
      throw AssertionError('When "isSvgIcon" is false, "icon" must not be null');
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(color: GenericColors.ghostWhite, borderRadius: BorderRadius.circular(6.0)),
      child: Wrap(
        spacing: 4.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        // alignment: WrapAlignment.center,
        children: [
          isSvgIcon
              ? SvgPicture(AssetBytesLoader(svgIcon!), height: 14.0, width: 14.0, colorFilter: ColorFilter.mode(GenericColors.black, BlendMode.srcIn))
              : SizedBox(height: 14.0, width: 14.0, child: Icon(icon, size: 14.0, color: GenericColors.black)),
          Text(text, style: TextStyle(color: AppColors.textSecondary, fontSize: 11.0, height: 2.0)),
        ],
      ),
    );
  }
}
