import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:qoruz/controllers/market_place_controller.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/utils/constants/colors.dart';
import 'package:qoruz/utils/constants/enums.dart' show Status;
import 'package:qoruz/utils/constants/image_constants.dart';
import 'package:qoruz/utils/constants/theme/text_theme.dart';
import 'package:qoruz/utils/handlers/exception_handler.dart';
import 'package:qoruz/views/widgets/custom_image_container.dart';
import 'package:qoruz/views/widgets/custom_snackbar.dart';
import 'package:share_plus/share_plus.dart' show Share, ShareResultStatus;
import 'package:vector_graphics/vector_graphics.dart';

class MarketPlaceDetailScreen extends StatefulWidget {
  const MarketPlaceDetailScreen({super.key, required this.marketplaceRequest});

  final MarketplaceRequest marketplaceRequest;

  @override
  State<MarketPlaceDetailScreen> createState() => _MarketPlaceDetailScreenState();
}

class _MarketPlaceDetailScreenState extends State<MarketPlaceDetailScreen> {
  late MarketPlaceController _controller;

  Future<void> _fetchMarketPlaceDetail() async {
    /// All the data are available in the [widget.marketplaceRequest].
    ///
    /// For following the requirement document only the data is fetched using API.
    ///
    if (widget.marketplaceRequest.idHash == null) return;
    final response = await context.read<MarketPlaceController>().getMarketPlaceDetails(idHash: widget.marketplaceRequest.idHash!);
    if (!mounted) return;
    if (response.status == Status.error) {
      ExceptionHandler.handleUiException(context, status: response.status, message: response.message);
    }
  }

  Future<void> _deletePost() async {
    CustomSnackBar.show(context, title: 'Deleting Post...Please wait');
    Timer(Duration(seconds: 2), () {
      CustomSnackBar.show(context, title: 'Post Deleted Successfully');
      context.pop();
    });
  }

  Future<void> _sharePost() async {
    final result = await Share.share('Check out this post on Qoruz');
    if (!mounted) return;
    if (result.status == ShareResultStatus.success) {
      CustomSnackBar.show(context, title: 'Post shared successfully');
    } else {
      CustomSnackBar.show(context, title: 'Failed to share post');
    }
  }

  Future<void> _shareOnSocials({required String platform}) async {
    CustomSnackBar.show(context, title: 'Successfully shared on $platform');
  }

  Future<void> _takePostAction({required String action}) async {
    if (action == 'Edit') {
      CustomSnackBar.show(context, title: 'Post ${action}ed successfully');
    } else {
      CustomSnackBar.show(context, title: 'Post ${action}d successfully');
      context.pop();
    }
  }

  @override
  void initState() {
    _controller = context.read<MarketPlaceController>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchMarketPlaceDetail());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watch<MarketPlaceController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GenericColors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
        actions: [
          IconButton(icon: const Icon(Symbols.delete), color: AppColors.primary, onPressed: () => _deletePost()),
          GestureDetector(
            onTap: () => _sharePost(),
            child: Container(
              height: 28.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [GenericColors.deepOrange, GenericColors.pink]),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.share_outlined, color: GenericColors.white, size: 16.0),
            ),
          ),
          SizedBox(width: 16.0),
        ],
        shape: Border(bottom: BorderSide(color: GenericColors.lavenderGrey, width: 1.0)),
      ),
      bottomNavigationBar:
          _controller.marketPlaceDetail.status == Status.completed
              ? Container(
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
                            onPressed: () => _takePostAction(action: 'Edit'),
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(AppColors.primary),
                              side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary)),
                            ),
                            child: Text('Edit', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _takePostAction(action: 'Close'),
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
              )
              : SizedBox.shrink(),
      body: Builder(
        builder: (context) {
          switch (_controller.marketPlaceDetail.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case Status.error:
              return Center(child: Text(_controller.marketPlaceList.message ?? 'Error fetching market items'));
            case Status.completed:
            default:
              final data = _controller.marketPlaceDetail.data;
              return ListView(
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
                              imageUrl:
                                  data?.userDetails?.profileImage ??
                                  'https://industrial.uii.ac.id/wp-content/uploads/2019/09/385-3856300_no-avatar-png.jpg',
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        data?.userDetails?.name ?? 'User Name',
                                        style: TextStyle(color: AppColors.textDark, fontSize: 12.0, fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 5.0),
                                      Image.asset(AppIcons.linkedin, height: 12.0, width: 12.0),
                                      SizedBox(width: 5.0),
                                      SvgPicture(AssetBytesLoader(AppIcons.verified), height: 12.0, width: 12.0),
                                      Spacer(),
                                      Text(data?.createdAt ?? 'Created Time', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0)),
                                    ],
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    data?.userDetails?.designation ?? 'User Designation',
                                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0),
                                  ),
                                  SizedBox(height: 2.0),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 5.0,
                                    children: [
                                      Icon(Icons.corporate_fare, color: AppColors.textSecondary, size: 14.0),
                                      Text(data?.userDetails?.company ?? 'Company', style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary)),
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
                            Text(
                              'Highlights',
                              style: TextStyle(color: AppColors.textTertiary, fontSize: 12.0, fontWeight: FontWeight.w700, height: 1.6),
                            ),
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
                        Text(data?.description ?? 'Request Description', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                        SizedBox(height: 16.0),
                        Row(
                          // direction: Axis.horizontal,
                          // spacing: 8.0,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          // alignment: WrapAlignment.center,
                          children: [
                            Expanded(
                              child: SocialsContainer(
                                prefix: 'Share via',
                                platform: 'WhatsApp',
                                logo: AppIcons.whatsapp,
                                color: GenericColors.neonGreen,
                                onTap: (platform) => _shareOnSocials(platform: platform),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: SocialsContainer(
                                prefix: 'Share on',
                                platform: 'LinkedIn',
                                logo: AppIcons.linkedin,
                                color: GenericColors.brightRoyalBlue,
                                onTap: (platform) => _shareOnSocials(platform: platform),
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
                            HighlightedDetail(title: 'Category', value: data?.requestDetails?.categories?.join(', ') ?? 'No Categories'),
                            HighlightedDetail(title: 'Platform', value: data?.requestDetails?.platform?.join(', ') ?? 'No Platforms'),
                            HighlightedDetail(title: 'Language', value: data?.requestDetails?.languages?.join(', ') ?? 'No Languages'),
                            HighlightedDetail(title: 'Location', value: data?.requestDetails?.cities?.join(', ') ?? 'No Cities'),
                            HighlightedDetail(
                              title: 'Required Count',
                              value:
                                  '${(data?.requestDetails?.creatorCountMin ?? 0) == 0 && (data?.requestDetails?.creatorCountMax ?? 0) == 0 ? 0 : '${data?.requestDetails?.creatorCountMin ?? 0} - ${data?.requestDetails?.creatorCountMax ?? 0}'}',
                            ),
                            HighlightedDetail(title: 'Our Budget', value: data?.requestDetails?.budget ?? 'No Budget'),
                            HighlightedDetail(title: 'Brand Collab With', value: data?.requestDetails?.brand ?? 'No Brand'),
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
              );
          }
        },
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
  const SocialsContainer({super.key, required this.prefix, required this.platform, required this.logo, required this.color, required this.onTap});

  final String prefix, platform, logo;
  final Color color;
  final void Function(String platform) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(platform),
      child: Container(
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
