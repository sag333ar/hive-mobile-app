import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/images/image_container.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/controller/user_post_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/view/user_posts_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_mute_buttons.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_menu.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_tab_bar.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_user_info.dart';
import 'package:provider/provider.dart';

class UserProfileWebViewWidget extends StatefulWidget {
  const UserProfileWebViewWidget(
      {super.key,
      required this.accountName,
      required this.data,
      required this.child,
      required this.postType});

  final String accountName;
  final UserModel data;
  final Widget child;
  final AccountPostType postType;

  @override
  State<UserProfileWebViewWidget> createState() =>
      _UserProfileWebViewWidgetState();
}

class _UserProfileWebViewWidgetState extends State<UserProfileWebViewWidget> {
  late final ScrollController scrollController;
  VoidCallback loadNextPageCallback = () {};

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListnerer);
    super.initState();
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
            _coverImage(),
            SliverCrossAxisGroup(
              slivers: [
                if (context.isDesktopSize)
                  SliverConstrainedCrossAxis(
                    maxExtent: 300,
                    sliver: SliverToBoxAdapter(
                      child: UserProfileMenu(
                        item: widget.data,
                      ),
                    ),
                  ),
                SliverMainAxisGroup(
                  slivers: [
                    UserProfileUserInfo(data: widget.data),
                    _tabBar(context, theme, userProfileController),
                    _feedBody()
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
          offset: offset > 300 && context.isDesktopSize
              ? Offset.zero
              : const Offset(-0, -1),
          duration: const Duration(milliseconds: 50),
          child: Container(
            width: 300,
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
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ImageContainer(
                width: double.infinity,
                url: widget.data.postingJsonMetadata?.profile?.coverImage),
           if(context.isMobile && context.isMobileSize) const Positioned(
                bottom: 10,
                right: 10,
                child: UserProfileFollowMuteButtons(
                  buttonHeight: 30,
                ),)
          ],
        ),
      ),
    );
  }

  SliverAppBar _tabBar(BuildContext context, ThemeData theme,
      UserProfileController userProfileController) {
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      toolbarHeight: 0,
      pinned: context.isDesktopSize,
      floating: !context.isDesktopSize,
      backgroundColor: theme.colorScheme.tertiaryContainer,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: UserProfileTabBar(
                  accountName: widget.accountName,
                  onChange: () {
                    scrollController.jumpTo(0);
                    userProfileController.scrollOffset = 0;
                  },
                ),
              ),
            ),
            if (context.isDesktopSize)
              const Positioned(
                top: 0,
                right: kScreenHorizontalPaddingDigit,
                child: UserProfileFollowMuteButtons(),
              )
          ],
        ),
      ),
    );
  }

  ChangeNotifierProvider<UserPostController> _feedBody() {
    return ChangeNotifierProvider(
      key: ValueKey('${widget.accountName} ${widget.postType}'),
      create: (context) => UserPostController(
          postType: widget.postType, accountName: widget.accountName),
      builder: (context, child) {
        final userPostController = context.read<UserPostController>();
        loadNextPageCallback = userPostController.loadNextPage;
        return SliverMainAxisGroup(
          slivers: [
            UserPostViewWidget(
              key: ValueKey('${widget.accountName} ${widget.postType}'),
              accountName: widget.accountName,
              postType: widget.postType,
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
