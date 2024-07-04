import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';

extension PlatformNavigation on BuildContext {
  void platformPop({String? name}) {
    if (isWeb && name == null) {
      throw Exception('name is required for web platform');
    }
    if (canPop()) {
      pop();
    } else {
      goNamed(name!);
    }
  }

  void popAndPlatformPushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    pop();
    platformPushNamed(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  void popAndPushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    pop();
    pushNamed(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  void platformPushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      isMobile
          ? GoRouter.of(this).pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            )
          : GoRouter.of(this).goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  String currentRoute() {
    return GoRouter.of(this)
        .routerDelegate
        .currentConfiguration
        .uri
        .path
        .toString();
  }
}
