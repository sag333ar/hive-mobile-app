import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/view/proposal_view.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/view/witnesses_view.dart';
import 'package:hive_mobile_app/feature/user/models/navigation_model/user_follow_info_list_navigation_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/view/user_follow_info_list_widget.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_profile_root/user_profile_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/view/user_posts_view.dart';
import 'package:hive_mobile_app/home_view.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: routes());

  static List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/',
        name: Routes.initialView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/${Routes.homeView}/:feedType',
        name: Routes.homeView,
        builder: (context, state) {
          String? feedType = state.pathParameters['feedType'];
          return HomeView(
            feedType: feedType != null
                ? enumFromString(feedType, FeedType.values,
                    defaultValue: FeedType.hot)
                : null,
          );
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
          return const ProposalView();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          String accountName = state.pathParameters['accountName']!;
          return UserProfileView(
              accountName: accountName,
              postType: UserProfileView.getFeedTypeFromPath(state.fullPath!),
              child: child);
        },
        routes: [
          GoRoute(
            path: '/@:accountName',
            name: Routes.userView,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters['accountName']!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.blog,
              );
            },
          ),
          GoRoute(
            path: '/@:accountName/${Routes.userBlogView}',
            name: Routes.userBlogView,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters['accountName']!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.blog,
              );
            },
          ),
          GoRoute(
            path: '/@:accountName/${Routes.userPostsView}',
            name: Routes.userPostsView,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters['accountName']!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.posts,
              );
            },
          ),
          GoRoute(
            path: '/@:accountName/${Routes.userCommentsView}',
            name: Routes.userCommentsView,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters['accountName']!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.comments,
              );
            },
          ),
          GoRoute(
            path: '/@:accountName/${Routes.userRepliesView}',
            name: Routes.userRepliesView,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters['accountName']!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.replies,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/${Routes.userFollowInfoListView}',
        name: Routes.userFollowInfoListView,
        builder: (context, state) {
          UserFollowInfoListNavigationModel data =
              state.extra as UserFollowInfoListNavigationModel;
          return UserFollowInfoListWidget(
            accountName: data.accountName,
            type: data.type,
            count: data.count,
            removeScaffold: data.removeScaffold,
          );
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
