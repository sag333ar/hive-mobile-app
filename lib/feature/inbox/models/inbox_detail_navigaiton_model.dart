import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class InboxDetailNavigaitonModel {
  final PostFeedModel postFeedModel;
  final InboxController controller;

  const InboxDetailNavigaitonModel(
      {required this.controller, required this.postFeedModel});
}
