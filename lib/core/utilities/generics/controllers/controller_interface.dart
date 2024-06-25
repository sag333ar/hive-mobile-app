import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';

abstract class ControllerInterface<T> {
  List<T> items = [];
  ViewState viewState = ViewState.loading;

  @protected
  void init();

  void loadNextPage();

  void refresh();
}
