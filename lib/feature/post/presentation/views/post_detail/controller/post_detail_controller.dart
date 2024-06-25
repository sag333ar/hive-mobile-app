import 'package:flutter/foundation.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_detail/post_detail_model.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class PostDetailController extends ChangeNotifier {
  final PostRepository _repository = getIt<PostRepository>();
  final String accountName;
  final String permlink;
  ViewState viewState = ViewState.loading;
  late final PostDetailModel data;

  PostDetailController({
    required this.accountName,
    required this.permlink,
  }) {
    _init();
  }

  void _init() async {
    ActionSingleDataResponse<PostDetailModel> response =
        await _repository.getPostDetail(accountName, permlink);
    if (response.isSuccess && response.data != null) {
      viewState = ViewState.data;
      data = response.data!;
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
