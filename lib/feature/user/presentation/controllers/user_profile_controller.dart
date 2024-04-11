import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/follow_count_model.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class UserProfileController extends ChangeNotifier {
  final UserRepository _userRepository = getIt<UserRepository>();
  final String accountName;
  UserModel? data;
  ViewState viewState = ViewState.loading;
  double _scrollOffset = 0.0;

  UserProfileController({required this.accountName}) {
    _init();
  }

  void _init() async {
    ActionSingleDataResponse<UserModel> response =
        await _userRepository.getAccountInfo(accountName);
    if (response.isSuccess && response.data != null) {
      viewState = ViewState.data;
      data = response.data;
    } else {
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  Future<FollowCountModel> getFollowCount() async {
    ActionSingleDataResponse<FollowCountModel> response =
        await _userRepository.getFollowCount(accountName);
    if (response.isSuccess) {
      return response.data!;
    } else {
      return FollowCountModel(followerCount: 0, followingCount: 0);
    }
  }

  Future<int> getUserReputation() async {
    return await _userRepository.getUserReputation(accountName);
  }

  double get scrollOffset => _scrollOffset;

  set scrollOffset(double value) {
    _scrollOffset = value;
    notifyListeners();
  }

  void refresh() {
    viewState = ViewState.loading;
    notifyListeners();
  }
}
