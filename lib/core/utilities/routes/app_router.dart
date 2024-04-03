import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/view/home_view.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: routes());

  static List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/${Routes.homeView}',
        name: Routes.homeView,
        builder: (context, state) {
          return const HomeView();
        },
      ),

  
    ];
  }

  static bool? _stringToBool(String? value) {
    if (value != null) {
      return value.toLowerCase() == "true";
    }
    return null;
  }

  static void popTillFirstScreen(
    BuildContext context,
  ) {
    while (router
            .routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        '/') {
      if (!context.canPop()) {
        return;
      }
      context.pop();
    }
  }
}
