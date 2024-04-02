import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_tab_bar.dart';
import 'package:hive_mobile_app/core/common/widgets/hive_symbol_logo.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/home_feed_widget.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_tabBarListener);
    super.initState();
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorLight,
        title: const HiveSymbolLogo(),
        bottom: ColoredTabBar(
          color: theme.primaryColorLight,
          tabBar: TabBar(
            controller: _tabController,
            indicatorColor: theme.primaryColor,
            dividerColor: theme.primaryColorDark.withOpacity(0.2) ,
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
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeFeedWidget(feedType: FeedType.hot),
          HomeFeedWidget(feedType: FeedType.trending),
          HomeFeedWidget(feedType: FeedType.created),
          SizedBox.shrink()
        ],
      ),
    );
  }
}
