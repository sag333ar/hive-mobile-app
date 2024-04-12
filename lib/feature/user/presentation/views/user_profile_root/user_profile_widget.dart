import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/images/image_container.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar_item.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/controller/user_post_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/view/user_posts_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_profile_root/user_profile_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_navigating_sliver_appbar.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_mute_buttons.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_menu.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/user_profile_user_info.dart';
import 'package:provider/provider.dart';

class UserProfileViewWidget extends StatefulWidget {
  const UserProfileViewWidget(
      {super.key,
      required this.accountName,
      required this.data,
      required this.child,
      required this.routeType});

  final String accountName;
  final UserModel data;
  final Widget child;
  final UserProfileRouteType routeType;

  @override
  State<UserProfileViewWidget> createState() => _UserProfileViewWidgetState();
}

class _UserProfileViewWidgetState extends State<UserProfileViewWidget> {
  late final ScrollController scrollController;
  VoidCallback loadNextPageCallback = () {};

  UserPostController? blogController;
  UserPostController? postsController;
  UserPostController? commentsController;
  UserPostController? repliesController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListnerer);
    _initFeedsController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserProfileViewWidget oldWidget) {
    _initFeedsController();
    super.didUpdateWidget(oldWidget);
  }

  _initFeedsController() {
    if (widget.routeType == UserProfileRouteType.blog &&
        blogController == null) {
      blogController = UserPostController(
          accountName: widget.accountName, postType: AccountPostType.blog);
    } else if (widget.routeType == UserProfileRouteType.posts &&
        postsController == null) {
      postsController = UserPostController(
          accountName: widget.accountName, postType: AccountPostType.posts);
    } else if (widget.routeType == UserProfileRouteType.comments &&
        commentsController == null) {
      commentsController = UserPostController(
          accountName: widget.accountName, postType: AccountPostType.comments);
    } else if (widget.routeType == UserProfileRouteType.replies &&
        repliesController == null) {
      repliesController = UserPostController(
          accountName: widget.accountName, postType: AccountPostType.replies);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListnerer);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListnerer() {
    if (scrollController.hasClients &&
        scrollController.offset == scrollController.position.maxScrollExtent) {
      loadNextPageCallback();
    }
    context.read<UserProfileController>().scrollOffset =
        scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProfileController = context.read<UserProfileController>();
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
                      child: UserProfileMenu(
                        item: widget.data,
                      ),
                    ),
                  ),
                SliverMainAxisGroup(
                  slivers: [
                     _coverImage(),
                    if (!context.isDesktopSize)
                      UserProfileUserInfo(data: widget.data),
                    _tabBar(context, theme, userProfileController),
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

  Selector<UserProfileController, double> _userImageTextAppbar(
      ThemeData theme) {
    return Selector<UserProfileController, double>(
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
                url: widget.data.postingJsonMetadata?.profile?.coverImage),
            if (context.isMobile && context.isMobileSize)
              const Positioned(
                bottom: 10,
                right: 10,
                child: UserProfileFollowMuteButtons(
                  buttonHeight: 30,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _tabBar(BuildContext context, ThemeData theme,
      UserProfileController userProfileController) {
    return ProfileSliverAppbar(
        tabBar: RoutedTabBar(
          pathParameter: {'accountName': widget.accountName},
          routes: [
            RoutedTabBarItem(
              displayName: 'Blog',
              routeName: Routes.userBlogView,
            ),
            RoutedTabBarItem(
              displayName: 'Posts',
              routeName: Routes.userPostsView,
            ),
            RoutedTabBarItem(
              displayName: 'Comments',
              routeName: Routes.userCommentsView,
            ),
            RoutedTabBarItem(
              displayName: 'Replies',
              routeName: Routes.userRepliesView,
            ),
          ],
          onChange: () {
            scrollController.jumpTo(0);
            userProfileController.scrollOffset = 0;
          },
        ),
        actionButtons: const UserProfileFollowMuteButtons());
  }

  Widget get body {
    switch (widget.routeType) {
      case UserProfileRouteType.blog:
        return _feedBody(AccountPostType.blog, blogController!);
      case UserProfileRouteType.posts:
        return _feedBody(AccountPostType.posts, postsController!);
      case UserProfileRouteType.comments:
        return _feedBody(AccountPostType.comments, commentsController!);
      case UserProfileRouteType.replies:
        return _feedBody(AccountPostType.replies, repliesController!);
    }
  }

  ChangeNotifierProvider<UserPostController> _feedBody(
      AccountPostType postType, UserPostController controller) {
    return ChangeNotifierProvider.value(
      value: controller,
      key: ValueKey('${widget.accountName} $postType'),
      builder: (context, child) {
        loadNextPageCallback = controller.loadNextPage;
        return SliverMainAxisGroup(
          slivers: [
            UserPostViewWidget(
              key: ValueKey('${widget.accountName} $postType'),
              accountName: widget.accountName,
              postType: postType,
            ),
            SliverToBoxAdapter(
              child: PaginationLoader(
                pageVisibilityListener: (context) =>
                    context.select<UserPostController, bool>(
                        (value) => value.isNextPageLoading),
              ),
            )
          ],
        );
      },
    );
  }
}
