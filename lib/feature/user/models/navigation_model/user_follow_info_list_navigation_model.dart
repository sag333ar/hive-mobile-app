import 'package:hive_mobile_app/core/utilities/enum.dart';

class UserFollowInfoListNavigationModel {
  final FollowType type;
  final String accountName;
  final bool removeScaffold;
  final int count;

  UserFollowInfoListNavigationModel(
      {required this.type,
      required this.accountName,
      required this.removeScaffold,
      required this.count});
}
