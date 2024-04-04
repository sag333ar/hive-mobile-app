import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';

mixin PaginationMixin  {
  int pageLimit = 20;
  bool isPageEnded = false;
  bool isNextPageLoading = false;

  @protected
  Future<ActionListDataResponse<T>?> loadMore<T>({
    required Future<ActionListDataResponse<T>> Function() apiCall,
  }) async {
    if (!isPageEnded && !isNextPageLoading) {
      isNextPageLoading = true;
      ActionListDataResponse<T> response = await apiCall();
      if (response.isSuccess) {
        if (response.data!.length < pageLimit) {
          isPageEnded = true;
        }
      }
      isNextPageLoading = false;
      return response;
    }
    return null;
  }
}
