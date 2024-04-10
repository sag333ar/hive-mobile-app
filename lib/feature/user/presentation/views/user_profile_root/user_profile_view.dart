import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_profile_root/webview/user_profile_web_view_widget.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView(
      {super.key,
      required this.accountName,
      required this.child,
      required this.postType});

  final String accountName;
  final Widget child;
  final AccountPostType postType;

  static AccountPostType getFeedTypeFromPath(String path) {
    int count = path.split('/').length - 1;
    if (count == 1) {
      return AccountPostType.blog;
    } else if (path.contains(enumToString(AccountPostType.blog))) {
      return AccountPostType.blog;
    } else if (path.contains(enumToString(AccountPostType.posts))) {
      return AccountPostType.posts;
    } else if (path.contains(enumToString(AccountPostType.comments))) {
      return AccountPostType.comments;
    } else if (path.contains(enumToString(AccountPostType.replies))) {
      return AccountPostType.replies;
    }
    return AccountPostType.blog;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      key: ValueKey(accountName),
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProfileController(accountName: accountName),
        ),
      ],
      builder: (context, child) {
        final controller = context.read<UserProfileController>();
        return Scaffold(
            backgroundColor: theme.colorScheme.tertiaryContainer,
            body: Selector<UserProfileController, ViewState>(
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
    return Selector<UserProfileController, UserModel>(
      selector: (_, provider) => provider.data!,
      builder: (context, data, chidld) {
        return UserProfileWebViewWidget(
            postType: postType,
            accountName: accountName,
            data: data,
            child: child);
      },
    );
  }
}
