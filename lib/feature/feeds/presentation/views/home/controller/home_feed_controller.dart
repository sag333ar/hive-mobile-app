import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/feature/feeds/repository/feeds_repository.dart';

class HomeFeedController extends ChangeNotifier {
  final FeedsRepository _repository = getIt<FeedsRepository>();
  List<PostFeedModel> items = [];
  final FeedType feedType;

  ViewState viewState = ViewState.loading;

  HomeFeedController({required this.feedType}) {
    _init();
  }

  void _init() async {
    var response = await _repository.getFeeds(feedType);
    if (response.isSuccess) {
      if (response.data!.isNotEmpty) {
        items = response.data!;
        viewState = ViewState.data;
      } else {
        viewState = ViewState.empty;
      }
    } else {
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  void refresh() {
    viewState = ViewState.loading;
    notifyListeners();
    _init();
  }
}
