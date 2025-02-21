import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:qoruz/controllers/market_place_controller.dart';
import 'package:qoruz/models/market_place_list_model.dart';
import 'package:qoruz/routes/app_routes.dart' show AppRoutes;
import 'package:qoruz/utils/constants/colors.dart';
import 'package:qoruz/utils/constants/enums.dart' show Status;
import 'package:qoruz/utils/constants/image_constants.dart';
import 'package:qoruz/utils/handlers/exception_handler.dart';
import 'package:qoruz/views/widgets/custom_image_container.dart' show NetworkImageContainer;
import 'package:qoruz/views/widgets/custom_snackbar.dart';
import 'package:readmore/readmore.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  late MarketPlaceController _controller;
  late ScrollController _scrollController;
  final List<MarketplaceRequest> _marketPlaceList = [];

  Future<void> _fetchData({required String page}) async {
    CustomSnackBar.show(context, title: 'Fetching MarketPlace List...');
    final response = await _controller.getMarketPlaceList(page: page);
    if (!mounted) return;
    if (response.status == Status.error) {
      ExceptionHandler.handleUiException(context, status: response.status, message: response.message);
    } else if (response.status == Status.completed) {
      _marketPlaceList.addAll(response.data?.marketplaceRequests ?? []);
    }
  }

  void _scrollListener() {
    final currentPage = _controller.marketPlaceList.data?.pagination?.currentPage ?? 0;
    final totalPages = _controller.marketPlaceList.data?.pagination?.totalPages ?? 0;
    final scrollPosition = _scrollController.position.maxScrollExtent / _scrollController.position.pixels;
    bool isFetching = _controller.marketPlaceList.status == Status.loading;
    print(scrollPosition);
    if (currentPage < totalPages && scrollPosition < 1.2 && !isFetching) {
      _fetchData(page: (currentPage + 1).toString());
    } else if (currentPage == totalPages && scrollPosition == 1.0) {
      CustomSnackBar.show(context, title: 'End of List');
    }
  }

  @override
  void initState() {
    _controller = context.read<MarketPlaceController>();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(page: '1'));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watch<MarketPlaceController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [GenericColors.deepOrange, GenericColors.pink]))),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu_open_rounded, color: GenericColors.white))],
      ),

      floatingActionButton: Container(
        height: 40.0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: AppColors.primaryDark.withValues(alpha: 0.2), offset: Offset(0, 12), spreadRadius: 0.0, blurRadius: 34.0)],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Post Request'),
          icon: Icon(Icons.add_rounded),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          foregroundColor: AppColors.textLight,
          backgroundColor: AppColors.primary,
          elevation: 0.0,
          extendedPadding: EdgeInsets.fromLTRB(12.0, 8.0, 20.0, 8.0),
          extendedTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: Container(
        height: 73.0,
        padding: EdgeInsets.only(top: 12.0, bottom: 18.0),
        decoration: BoxDecoration(
          color: GenericColors.white,
          boxShadow: [BoxShadow(color: Color(0xFF000000).withValues(alpha: 0.08), offset: Offset(4.0, 0.0), spreadRadius: 0.0, blurRadius: 4.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBottomNavigationItem(isSvgIcon: true, svgIcon: AppIcons.explore, label: 'Explore', onTap: () {}),
            CustomBottomNavigationItem(icon: Icons.storefront_outlined, label: 'Marketplace', isNew: true, selected: true, onTap: () {}),
            CustomBottomNavigationItem(isSvgIcon: true, svgIcon: AppIcons.search, label: 'Search', onTap: () {}),
            CustomBottomNavigationItem(isSvgIcon: true, svgIcon: AppIcons.activities, label: 'Activity', onTap: () {}),
            CustomBottomNavigationItem(isSvgIcon: true, svgIcon: AppIcons.profile, label: 'Profile', onTap: () {}),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: GenericColors.white,
                border: Border.all(color: GenericColors.grey),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(color: GenericColors.black.withValues(alpha: 0.06), blurRadius: 20.0, spreadRadius: 0.0, offset: Offset(0.0, 0.0)),
                ],
              ),
              child: Row(
                children: [
                  NetworkImageContainer(
                    imageUrl: 'https://yt3.googleusercontent.com/ytc/AGIKgqNi-oVtCDPwSmhxBAPe887CDr_zC5_i5xuWqCI8=s900-c-k-c0x00ffffff-no-rj',
                    height: 32.0,
                    width: 32.0,
                    borderRadius: 25.0,
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Type your requirement here . . .',
                        hintStyle: TextStyle(fontSize: 14.0, color: AppColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36.0,
            child: ListView(
              padding: EdgeInsets.only(left: 16.0, right: 6.0),
              scrollDirection: Axis.horizontal,
              children: [
                QuickFilterChip(label: 'For You'),
                QuickFilterChip(label: 'Recent', selected: true),
                QuickFilterChip(label: 'My Requests'),
                QuickFilterChip(label: 'Top Deals', icon: Icons.star_outline),
              ],
            ),
          ),

          Expanded(
            child:
                _marketPlaceList.isEmpty
                    ? Builder(
                      builder: (context) {
                        switch (_controller.marketPlaceList.status) {
                          case Status.loading:
                            return const Center(child: CircularProgressIndicator.adaptive());
                          case Status.error:
                            return Center(child: Text(_controller.marketPlaceList.message ?? 'Error fetching market items'));
                          case Status.completed:
                          default:
                            return MarketPlaceList(scrollController: _scrollController, controller: _controller);
                        }
                      },
                    )
                    : MarketPlaceList(scrollController: _scrollController, controller: _controller),
          ),
        ],
      ),
    );
  }
}

class MarketPlaceList extends StatelessWidget {
  const MarketPlaceList({super.key, required ScrollController scrollController, required MarketPlaceController controller})
    : _scrollController = scrollController,
      _controller = controller;

  final ScrollController _scrollController;
  final MarketPlaceController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 126.0),
      itemBuilder: (context, index) {
        final data = _controller.marketPlaceList.data?.marketplaceRequests?[index];

        return GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.marketplaceDetail, extra: data),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: GenericColors.white,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(color: GenericColors.black.withValues(alpha: 0.06), blurRadius: 20.0, spreadRadius: 0.0, offset: Offset(0.0, 0.0)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: NetworkImageContainer(
                          imageUrl:
                              data?.userDetails?.profileImage ??
                              'https://industrial.uii.ac.id/wp-content/uploads/2019/09/385-3856300_no-avatar-png.jpg',
                          height: 48.0,
                          width: 48.0,
                          borderRadius: 100.0,
                        ),
                        title: Text(data?.userDetails?.name ?? 'User Name'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data?.userDetails?.designation} at ${data?.userDetails?.company}',
                              style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.schedule, size: 12.0, color: AppColors.textTertiary),
                                SizedBox(width: 4.0),
                                Text(data?.createdAt ?? 'No Time', style: TextStyle(fontSize: 10.0, color: AppColors.textTertiary)),
                              ],
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.textSecondary),
                        titleTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.textDark),
                      ),
                      if (data?.icon != null) ...[
                        Row(
                          children: [
                            ShaderMask(
                              shaderCallback:
                                  (bounds) => LinearGradient(colors: data!.colors ?? [], begin: data.begin!, end: data.end!).createShader(bounds),
                              blendMode: BlendMode.srcIn,
                              child: Icon(data?.icon, size: 14.0),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Looking for ${data?.serviceType}',
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: AppColors.textDark),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0),
                      ],
                      Divider(color: AppColors.border, thickness: 1.0),
                      DescriptionWidget(data: data),
                    ],
                  ),
                ),
              ),
              if (data?.isHighValue ?? false) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(colors: [Color(0xFFFE9C13), Color(0xFFFB9428)]),
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Icon(Symbols.award_star_rounded, size: 14.0, color: AppColors.textLight),
                          SizedBox(width: 4.0),
                          Text('HIGH VALUE', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: AppColors.textLight)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
      itemCount: _controller.marketPlaceList.data?.marketplaceRequests?.length ?? 0,
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({super.key, required this.data});

  final MarketplaceRequest? data;

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  late final ValueNotifier<bool> _isDescriptionCollapsed, _isLocationCollapsed;

  @override
  void initState() {
    _isDescriptionCollapsed = ValueNotifier<bool>(true);
    _isLocationCollapsed = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    _isDescriptionCollapsed.dispose();
    _isLocationCollapsed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadMoreText(
          widget.data?.description ?? 'No Description',
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'see more',
          trimExpandedText: 'see less',
          colorClickableText: AppColors.textSecondary,
          isCollapsed: _isDescriptionCollapsed,
        ),
        ValueListenableBuilder(
          valueListenable: _isDescriptionCollapsed,
          builder: (context, collapsed, child) {
            if (collapsed) return const SizedBox.shrink();
            return Column(children: [MoreInfoContainer()]);
          },
        ),
      ],
    );
  }
}

class MoreInfoContainer extends StatelessWidget {
  const MoreInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(color: GenericColors.ghostWhite, borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Symbols.distance), SizedBox(width: 4.0), Flexible(child: ReadMoreText('fsf', preDataText: 'TEst', postDataText: 'dxwd'))],
      ),
    );
  }
}

class CustomBottomNavigationItem extends StatelessWidget {
  const CustomBottomNavigationItem({
    super.key,
    this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
    this.isNew = false,
    this.svgIcon,
    this.isSvgIcon = false,
  });

  final bool isSvgIcon;
  final String? svgIcon;
  final IconData? icon;
  final String label;
  final bool selected, isNew;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color iconColor, labelColor;

    if (selected) {
      iconColor = AppColors.primary;
      labelColor = AppColors.textDark;
    } else {
      iconColor = AppColors.textSecondary;
      labelColor = AppColors.textSecondary;
    }

    if (isSvgIcon && (svgIcon == null || svgIcon!.isEmpty)) {
      throw AssertionError('When "isSvgIcon" is true, "svgIcon" must not be null or empty');
    } else if (!isSvgIcon && icon == null) {
      throw AssertionError('When "isSvgIcon" is false, "icon" must not be null');
    }

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            isSvgIcon
                ? SvgPicture(AssetBytesLoader(svgIcon!), colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn))
                : Icon(icon, color: iconColor),
            Spacer(),
            Text(label, style: TextStyle(fontSize: 12.0, color: labelColor)),
          ],
        ),
        if (isNew) ...[
          Positioned(
            right: 4.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(color: GenericColors.brightRed, borderRadius: BorderRadius.circular(25.0)),
              child: Text('NEW', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w700, color: AppColors.textLight)),
            ),
          ),
        ],
      ],
    );
  }
}

class QuickFilterChip extends StatelessWidget {
  const QuickFilterChip({super.key, required this.label, this.icon, this.selected = false});

  final String label;
  final IconData? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Chip(
        backgroundColor: selected ? AppColors.primaryLight : GenericColors.white,
        avatar:
            icon != null
                ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [GenericColors.amber, GenericColors.orange]).createShader(bounds),
                  child: Icon(icon),
                )
                : null,
        label: Text(label),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selected ? AppColors.primary : AppColors.border),
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
