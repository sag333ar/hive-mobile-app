import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/mixins/pagination_mixin.dart';

class Controller<T> extends ChangeNotifier with PaginationMixin {
  List<T> items = [];
  ViewState viewState = ViewState.loading;

  Future<ActionListDataResponse<T>> Function()? initCallBack;
  Future<ActionListDataResponse<T>> Function()? paginationCallBack;

  @protected
  void init() async {
    if (initCallBack == null) throw UnimplementedError('init api is not set');
    ActionListDataResponse<T> response = await initCallBack!();
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

  @required
  @protected
  void setInitApi(Future<ActionListDataResponse<T>> Function() initApi) {
    initCallBack = initApi;
  }

  @required
  @protected
  void setPaginationApi(
      Future<ActionListDataResponse<T>> Function() paginationApi) {
    paginationCallBack = paginationApi;
  }

  void loadNextPage() async {
    if (paginationCallBack == null) {
      throw UnimplementedError('Pagination Api is not set');
    }
    ActionListDataResponse<T>? newData = await loadMore<T>(
        apiCall: () => paginationCallBack!(), notifyListeners: notifyListeners);
    if (newData != null) {
      if (newData.isSuccess) {
        addItems(newData.data!);
      }
    }
  }

  void refresh() {
    viewState = ViewState.loading;
    initCallBack!();
  }

  @protected
  void addItems(List<T> newItems) {
    items = [...items, ...newItems];
    notifyListeners();
  }
}
