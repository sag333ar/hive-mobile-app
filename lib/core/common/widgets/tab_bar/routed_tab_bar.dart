import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar_item.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/app_router.dart';
import 'package:hive_mobile_app/core/common/widgets/tab_bar/routed_tab_bar_tile.dart';

class RoutedTabBar extends StatefulWidget {
  const RoutedTabBar(
      {super.key,
      required this.pathParameter,
      required this.onChange,
      required this.routes});

  final Map<String, String> pathParameter;
  final VoidCallback onChange;
  final List<RoutedTabBarItem> routes;

  @override
  State<RoutedTabBar> createState() => _RoutedTabBarState();
}

class _RoutedTabBarState extends State<RoutedTabBar> {
  @override
  Widget build(BuildContext context) {
    final String currentRoute = AppRouter.currentRoute();
    log(currentRoute);
    return Padding(
      padding: const EdgeInsets.only(
          left: kScreenHorizontalPaddingDigit,
          right: kScreenHorizontalPaddingDigit,
          bottom: 10),
      child: Row(
        children: List.generate(widget.routes.length, (index) {
          RoutedTabBarItem item = widget.routes[index];
          return RoutedTabBarTile(
            isSelected: (index == 0 ? isRootview(currentRoute) : false) ||
                currentRoute.contains(item.routeName),
            text: item.displayName,
            onTap: () => _goToRoute(item.routeName),
          );
        }),
      ),
    );
  }

  bool isRootview(String str) {
    int count = str.split('/').length - 1;
    return count == 1;
  }

  void _goToRoute(String route) {
    if (mounted) {
      widget.onChange();
      context.goNamed(route, pathParameters: widget.pathParameter);
      setState(() {});
    }
  }
}
