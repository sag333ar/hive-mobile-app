import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_tab_bar.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/drawer_menu.dart';
import 'package:hive_mobile_app/core/common/widgets/hive_symbol_logo.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/view/community_list_widget_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/view/post_feeds_widget_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TabController _tabController;
  int _currentIndex = 0;
  late ThemeData theme;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_tabBarListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabBarListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabBarListener() {
    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.isMobile ? null : theme.cardColor,
        drawer: const DrawerMenu(),
        body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                backgroundColor: theme.primaryColorLight,
                surfaceTintColor: theme.primaryColorLight,
                title: (context.isMobileSize)
                    ? const HiveSymbolLogo()
                    : _webViewTabBar(),
                floating: context.isTouchScreen,
                snap: context.isTouchScreen,
                pinned: !context.isTouchScreen,
                bottom: context.isMobileSize
                    ? ColoredTabBar(
                        color: theme.primaryColorLight,
                        tabBar: _tabBar(),
                      )
                    : null,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            physics:
                context.isWeb ? const NeverScrollableScrollPhysics() : null,
            children: const [
              PostFeedsWidgetView(feedType: FeedType.hot),
              PostFeedsWidgetView(feedType: FeedType.trending),
              PostFeedsWidgetView(feedType: FeedType.created),
              CommunityListWidgetView()
            ],
          ),
        ));
  }

  Widget _webViewTabBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Align(alignment: Alignment.centerLeft, child: HiveSymbolLogo()),
        if (!context.isMobileSize) _miniTabBar()
      ],
    );
  }

  TabBar _tabBar({Color? dividerColor}) {
    return TabBar(
      controller: _tabController,
      isScrollable: false,
      indicatorColor: theme.primaryColor,
      dividerColor: dividerColor ?? theme.primaryColorDark.withOpacity(0.2),
      overlayColor: MaterialStatePropertyAll(theme.primaryColor),
      onTap: (value) {
        if (mounted) {
          setState(() {
            _currentIndex = value;
          });
        }
      },
      tabs: const [
        Tab(icon: Icon(Icons.local_fire_department_outlined)),
        Tab(icon: Icon(Icons.trending_up)),
        Tab(icon: Icon(Icons.pin)),
        Tab(icon: Icon(Icons.handshake)),
      ],
    );
  }

  Widget _miniTabBar() {
    return SizedBox(
      width: 320,
      child: _tabBar(dividerColor: Colors.transparent),
    );
  }
}
