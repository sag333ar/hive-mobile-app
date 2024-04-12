import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/repository/community_repository.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class CommunityProfileController extends ChangeNotifier {
  final UserRepository _userRepository = getIt<UserRepository>();
  final CommunityRepository _communityRepository = getIt<CommunityRepository>();
  final String communityId;
  CommunityDetailModel? data;

  ViewState viewState = ViewState.loading;
  double _scrollOffset = 0.0;

  CommunityProfileController({required this.communityId}) {
    _init();
  }

  void _init() async {
    ActionSingleDataResponse<CommunityDetailModel> communityResponse =
        await _communityRepository.getCommunityDetails(communityId);
    ActionSingleDataResponse<UserModel> userResponse =
        await _userRepository.getAccountInfo(communityId);
    if (communityResponse.isSuccess &&
        communityResponse.data != null &&
        userResponse.isSuccess &&
        userResponse.data != null) {
      viewState = ViewState.data;
      data = communityResponse.data!.copyWith(community: userResponse.data!);
    } else {
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  double get scrollOffset => _scrollOffset;

  set scrollOffset(double value) {
    _scrollOffset = value;
    notifyListeners();
  }

  void refresh() {
    viewState = ViewState.loading;
    notifyListeners();
    _init();
  }
}
