import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/controller/community_profile_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_profile_root/community_profile_widget.dart';
import 'package:provider/provider.dart';

enum CommunityProfileRouteType {trending,hot,created,subscribers}

class CommunityProfileView extends StatelessWidget {
  const CommunityProfileView(
      {super.key,
      required this.communityId,
      required this.child,
      required this.routeType});

  final String communityId;
  final Widget child;
  final CommunityProfileRouteType routeType;

  static CommunityProfileRouteType getFeedTypeFromPath(String path) {
    int count = path.split('/').length - 1;
    if (count == 1) {
      return CommunityProfileRouteType.trending;
    } else if (path.contains(enumToString(CommunityProfileRouteType.trending))) {
      return CommunityProfileRouteType.trending;
    } else if (path.contains(enumToString(CommunityProfileRouteType.hot))) {
      return CommunityProfileRouteType.hot;
    } else if (path.contains(enumToString(CommunityProfileRouteType.created))) {
      return CommunityProfileRouteType.created;
    } else if (path.contains(enumToString(CommunityProfileRouteType.subscribers))) {
      return CommunityProfileRouteType.subscribers;
    }
    return CommunityProfileRouteType.trending;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      key: ValueKey(communityId),
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              CommunityProfileController(communityId: communityId),
        ),
      ],
      builder: (context, child) {
        final controller = context.read<CommunityProfileController>();
        return Scaffold(
            backgroundColor: theme.colorScheme.tertiaryContainer,
            body: Selector<CommunityProfileController, ViewState>(
              selector: (_, provider) => provider.viewState,
              builder: (context, value, child) {
                if (value == ViewState.data) {
                  return _dataState(theme);
                } else if (value == ViewState.empty) {
                  return const Emptystate(
                      icon: Icons.hourglass_empty, text: 'No Data found');
                } else if (value == ViewState.error) {
                  return ErrorState(
                      showRetryButton: true,
                      onTapRetryButton: controller.refresh);
                } else {
                  return const LoadingState();
                }
              },
            ));
      },
    );
  }

  Widget _dataState(ThemeData theme) {
    return Selector<CommunityProfileController, CommunityDetailModel>(
      selector: (_, provider) => provider.data!,
      builder: (context, data, chidld) {
        return CommunityProfileWidget(
            routeType: routeType,
            communityId: communityId,
            data: data,
            child: child);
      },
    );
  }
}
