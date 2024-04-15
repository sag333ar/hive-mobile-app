import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/images/image_container.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar_item.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/controller/community_profile_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_feeds/controller/community_feed_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_feeds/view/community_feed_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_profile_root/community_profile_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/controller/community_subscribers_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/view/community_subscribers_list_widget.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_profile_join_add_post_buttons.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_profile_menu.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/mobile_and_tablet/community_profile_info.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_navigating_sliver_appbar.dart';
import 'package:provider/provider.dart';

class CommunityProfileWidget extends StatefulWidget {
  const CommunityProfileWidget(
      {super.key,
      required this.communityId,
      required this.data,
      required this.child,
      required this.routeType});

  final String communityId;
  final CommunityDetailModel data;
  final Widget child;
  final CommunityProfileRouteType routeType;

  @override
  State<CommunityProfileWidget> createState() => _CommunityProfileWidgetState();
}

class _CommunityProfileWidgetState extends State<CommunityProfileWidget> {
  late final ScrollController scrollController;
  VoidCallback loadNextPageCallback = () {};
  CommunityFeedController? trendingFeedController;
  CommunityFeedController? hotFeedController;
  CommunityFeedController? createdFeedController;
  CommunitySubscribersListController? subscribersListController;

  @override
  void initState() {
    scrollController = ScrollController();
    _initFeedsController();
    scrollController.addListener(_scrollListnerer);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommunityProfileWidget oldWidget) {
    _initFeedsController();
    log('${enumToString(widget.routeType)} update');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListnerer);
    scrollController.dispose();
    super.dispose();
  }

  _initFeedsController() {
    if (widget.routeType == CommunityProfileRouteType.trending &&
        trendingFeedController == null) {
      trendingFeedController = CommunityFeedController(
          communityId: widget.communityId, feedType: FeedType.trending);
    } else if (widget.routeType == CommunityProfileRouteType.hot &&
        hotFeedController == null) {
      hotFeedController = CommunityFeedController(
          communityId: widget.communityId, feedType: FeedType.hot);
    } else if (widget.routeType == CommunityProfileRouteType.created &&
        createdFeedController == null) {
      createdFeedController = CommunityFeedController(
          communityId: widget.communityId, feedType: FeedType.created);
    } else if (widget.routeType == CommunityProfileRouteType.subscribers &&
        subscribersListController == null) {
      subscribersListController = CommunitySubscribersListController(
        communityId: widget.communityId,
      );
    }
  }

  void _scrollListnerer() {
    if (scrollController.hasClients &&
        scrollController.offset == scrollController.position.maxScrollExtent) {
      loadNextPageCallback();
    }
    context.read<CommunityProfileController>().scrollOffset =
        scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final communityProfileController =
        context.read<CommunityProfileController>();
    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverCrossAxisGroup(
              slivers: [
                if (context.isDesktopSize)
                  SliverConstrainedCrossAxis(
                    maxExtent: ProfileMenuTemplate.width,
                    sliver: SliverToBoxAdapter(
                      child: CommunityProfileMenu(
                        item: widget.data,
                      ),
                    ),
                  ),
                SliverMainAxisGroup(
                  slivers: [
                    _coverImage(),
                    if (!context.isDesktopSize)
                      CommunityProfileInfo(data: widget.data),
                    _tabBar(context, theme, communityProfileController),
                    body
                  ],
                ),
              ],
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 0,
          child: _userImageTextAppbar(theme),
        ),
      ],
    );
  }

  Widget get body {
    switch (widget.routeType) {
      case CommunityProfileRouteType.trending:
        return _feedBody(FeedType.trending, trendingFeedController!);
      case CommunityProfileRouteType.hot:
        return _feedBody(FeedType.hot, hotFeedController!);
      case CommunityProfileRouteType.created:
        return _feedBody(FeedType.created, createdFeedController!);
      case CommunityProfileRouteType.subscribers:
        return _subscribersListBody(subscribersListController!);
    }
  }

  Selector<CommunityProfileController, double> _userImageTextAppbar(
      ThemeData theme) {
    return Selector<CommunityProfileController, double>(
      selector: (_, provider) => provider.scrollOffset,
      builder: (context, offset, child) {
        return AnimatedSlide(
          offset: offset > 130 && context.isDesktopSize
              ? Offset.zero
              : const Offset(-0, -1),
          duration: const Duration(milliseconds: 50),
          child: Container(
            width: ProfileMenuTemplate.width + 4,
            color: theme.colorScheme.tertiaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: UserImageName(
              displayName: widget.data.title,
              name: widget.data.name,
            ),
          ),
        );
      },
    );
  }

  SliverAppBar _coverImage() {
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      toolbarHeight: 0,
      expandedHeight: 175,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ImageContainer(
                width: double.infinity,
                url: widget
                    .data.community!.postingJsonMetadata?.profile?.coverImage),
            if (context.isMobile && context.isMobileSize)
              const Positioned(
                bottom: 10,
                right: 10,
                child: CommunityProfileJoinAddPostButtons(
                  buttonHeight: 30,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _tabBar(BuildContext context, ThemeData theme,
      CommunityProfileController communityProfileController) {
    return ProfileSliverAppbar(
        tabBar: RoutedTabBar(
          pathParameter: {RouteKeys.communityId: widget.communityId},
          routes: [
            RoutedTabBarItem(
              displayName: 'Trending',
              routeName: Routes.communityTrendingView,
            ),
            RoutedTabBarItem(
              displayName: 'Hot',
              routeName: Routes.communityHotView,
            ),
            RoutedTabBarItem(
              displayName: 'Created',
              routeName: Routes.communityCreatedView,
            ),
            RoutedTabBarItem(
              displayName: 'Members',
              routeName: Routes.communitySubscribersView,
            ),
          ],
          onChange: () {
            scrollController.jumpTo(0);
            communityProfileController.scrollOffset = 0;
          },
        ),
        actionButtons: const CommunityProfileJoinAddPostButtons());
  }

  ChangeNotifierProvider<CommunityFeedController> _feedBody(
      FeedType feedType, CommunityFeedController controller) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        loadNextPageCallback = controller.loadNextPage;
        return SliverMainAxisGroup(
          slivers: [
            CommunityFeedViewWidget(
                feedType: feedType, communityId: widget.communityId),
            SliverToBoxAdapter(
              child: PaginationLoader(
                pageVisibilityListener: (context) =>
                    context.select<CommunityFeedController, bool>(
                        (value) => value.isNextPageLoading),
              ),
            )
          ],
        );
      },
    );
  }

  ChangeNotifierProvider<CommunitySubscribersListController>
      _subscribersListBody(CommunitySubscribersListController controller) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        loadNextPageCallback = controller.loadNextPage;
        return SliverMainAxisGroup(
          slivers: [
            CommunitySubscribersListWidget(
                removeScaffold: true,
                controller: controller,
                communityId: widget.communityId),
            SliverToBoxAdapter(
              child: PaginationLoader(
                pageVisibilityListener: (context) =>
                    context.select<CommunitySubscribersListController, bool>(
                        (value) => value.isNextPageLoading),
              ),
            )
          ],
        );
      },
    );
  }
}
