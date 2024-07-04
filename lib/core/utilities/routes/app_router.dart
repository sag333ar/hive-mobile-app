import 'package:auth/auth.dart';
import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_feeds/view/community_feed_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_profile_root/community_profile_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/view/community_subscribers_list_widget.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/view/proposal_view.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/view/witnesses_view.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/inbox_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/view/post_detail_view.dart';
import 'package:hive_mobile_app/feature/user/models/navigation_model/user_follow_info_list_navigation_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/view/subscribed_communities_widget.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/view/user_follow_info_list_widget.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_posts/view/user_posts_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_profile_root/user_profile_view.dart';
import 'package:hive_mobile_app/home_view.dart';

class AppRouter {
  final UserController _userController;
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _userProfileShellNavigatorKey = GlobalKey<NavigatorState>();
  static final _communityProfileShellNavigatorKey = GlobalKey<NavigatorState>();
  String? targetPath;

  AppRouter(this._userController);

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: routes(),
    refreshListenable: _userController,
    redirect: (context, state) async {
      final bool isLoggedIn = _userController.isUserLoggedIn;
      if (state.matchedLocation == "/${Routes.inboxView}" && !isLoggedIn) {
        await _userController.loadUserFromLocal();
        if (!_userController.isUserLoggedIn) {
          targetPath = "/${Routes.inboxView}";
          return "/${Routes.authView}?redirect=${state.matchedLocation}";
        }
        return null;
      } else if (state.matchedLocation == "/${Routes.authView}" &&
          isLoggedIn &&
          targetPath != null) {
        String redirectionPath = targetPath!;
        targetPath = null;
        return redirectionPath;
      } else if (state.matchedLocation == "/${Routes.authView}" && isLoggedIn) {
        return "/";
      }
      return null;
    },
  );

  List<RouteBase> routes() {
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
        path: '/${Routes.authView}',
        name: Routes.authView,
        builder: (context, state) {
          return AuthView(
            redirectionPath: targetPath,
          );
        },
      ),
      GoRoute(
        path: '/${Routes.proposalsView}',
        name: Routes.proposalsView,
        builder: (context, state) {
          return const ProposalView();
        },
      ),
      GoRoute(
        path: '/${Routes.inboxView}',
        name: Routes.inboxView,
        builder: (context, state) {
          return const InboxView();
        },
      ),
      ShellRoute(
        navigatorKey: _userProfileShellNavigatorKey,
        builder: (context, state, child) {
          String accountName = state.pathParameters[RouteKeys.accountName]!;
          return UserProfileView(
              accountName: accountName,
              routeType: UserProfileView.getFeedTypeFromPath(state.fullPath!),
              child: child);
        },
        routes: [
          GoRoute(
            path: '/@:${RouteKeys.accountName}',
            name: Routes.userView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters[RouteKeys.accountName]!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.blog,
              );
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userBlogView}',
            name: Routes.userBlogView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters[RouteKeys.accountName]!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.blog,
              );
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userPostsView}',
            name: Routes.userPostsView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters[RouteKeys.accountName]!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.posts,
              );
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userCommentsView}',
            name: Routes.userCommentsView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters[RouteKeys.accountName]!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.comments,
              );
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userRepliesView}',
            name: Routes.userRepliesView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              String accountName = state.pathParameters[RouteKeys.accountName]!;
              return UserPostViewWidget(
                accountName: accountName,
                postType: AccountPostType.replies,
              );
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userCommunitiesView}',
            name: Routes.userCommunitiesView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              return const SubscribedCommunitiesWidget();
            },
          ),
          GoRoute(
            path: '/@:${RouteKeys.accountName}/${Routes.userWalletView}',
            name: Routes.userWalletView,
            parentNavigatorKey: _userProfileShellNavigatorKey,
            builder: (context, state) {
              return const SubscribedCommunitiesWidget();
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
      ShellRoute(
        navigatorKey: _communityProfileShellNavigatorKey,
        builder: (context, state, child) {
          String communityid = state.pathParameters[RouteKeys.communityId]!;
          return CommunityProfileView(
              communityId: communityid,
              routeType:
                  CommunityProfileView.getFeedTypeFromPath(state.fullPath!),
              child: child);
        },
        routes: [
          GoRoute(
            path: '/:${RouteKeys.communityId}',
            name: Routes.communityView,
            parentNavigatorKey: _communityProfileShellNavigatorKey,
            builder: (context, state) {
              String communityId = state.pathParameters[RouteKeys.communityId]!;
              return CommunityFeedViewWidget(
                communityId: communityId,
                feedType: FeedType.trending,
              );
            },
          ),
          GoRoute(
            path: '/:${RouteKeys.communityId}/${Routes.communityTrendingView}',
            name: Routes.communityTrendingView,
            parentNavigatorKey: _communityProfileShellNavigatorKey,
            builder: (context, state) {
              String communityId = state.pathParameters[RouteKeys.communityId]!;
              return CommunityFeedViewWidget(
                communityId: communityId,
                feedType: FeedType.trending,
              );
            },
          ),
          GoRoute(
            path: '/:${RouteKeys.communityId}/${Routes.communityHotView}',
            name: Routes.communityHotView,
            parentNavigatorKey: _communityProfileShellNavigatorKey,
            builder: (context, state) {
              String communityId = state.pathParameters[RouteKeys.communityId]!;
              return CommunityFeedViewWidget(
                communityId: communityId,
                feedType: FeedType.hot,
              );
            },
          ),
          GoRoute(
            path: '/:${RouteKeys.communityId}/${Routes.communityCreatedView}',
            name: Routes.communityCreatedView,
            parentNavigatorKey: _communityProfileShellNavigatorKey,
            builder: (context, state) {
              String communityId = state.pathParameters[RouteKeys.communityId]!;
              return CommunityFeedViewWidget(
                communityId: communityId,
                feedType: FeedType.created,
              );
            },
          ),
          GoRoute(
            path:
                '/:${RouteKeys.communityId}/${Routes.communitySubscribersView}',
            name: Routes.communitySubscribersView,
            parentNavigatorKey: _communityProfileShellNavigatorKey,
            builder: (context, state) {
              String communityId = state.pathParameters[RouteKeys.communityId]!;
              return CommunitySubscribersListWidget(
                communityId: communityId,
                removeScaffold: true,
                count: 0,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/@:${RouteKeys.accountName}/:${RouteKeys.permlink}',
        name: Routes.postDetailView,
        builder: (context, state) {
          String accountName = state.pathParameters[RouteKeys.accountName]!;
          String permlink = state.pathParameters[RouteKeys.permlink]!;
          return PostDetailView(
            author: accountName,
            permlink: permlink,
          );
        },
      ),
    ];
  }

  String currentRoute() {
    return router.routerDelegate.currentConfiguration.uri.path.toString();
  }

  void popTillFirstScreen(
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
