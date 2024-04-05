import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/view/witnesses_view.dart';
import 'package:hive_mobile_app/home_view.dart';

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
       GoRoute(
        path: '/${Routes.witnessesView}',
        name: Routes.witnessesView,
        builder: (context, state) {
          return const WitnessesView();
        },
      ),
       GoRoute(
        path: '/${Routes.proposalsView}',
        name: Routes.proposalsView,
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
