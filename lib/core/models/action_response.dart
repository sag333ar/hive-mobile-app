import 'dart:convert';

import 'package:hive_mobile_app/core/utilities/enum.dart';

class ActionListDataResponse<T> {
  final String? id;
  final String? type;
  final List<T>? data;
  final bool valid;
  final String errorMessage;
  final ResponseStatus status;
  final bool isSuccess;

  ActionListDataResponse({
    this.id,
    this.type,
    this.data,
    this.isSuccess = false,
    this.valid = false,
    required this.status,
    required this.errorMessage,
  });

  factory ActionListDataResponse.fromJsonString(
          String string, T Function(dynamic) fromJson) =>
      ActionListDataResponse.fromJson(json.decode(string), fromJson);

  factory ActionListDataResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return ActionListDataResponse(
      id: json['id'] as String,
      type: json['type'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic item) => fromJson(item))
              .toList() ??
          [],
      status: json['valid'] && json['error'].isEmpty
          ? ResponseStatus.success
          : ResponseStatus.failed,
      isSuccess: json['valid'] && json['error'].isEmpty,
      valid: json['valid'] as bool,
      errorMessage: json['error'] as String,
    );
  }
}

class ActionSingleDataResponse<T> {
  final String? id;
  final String? type;
  final T? data;
  final bool valid;
  final String errorMessage;
  final ResponseStatus status;

  ActionSingleDataResponse(
      {this.id,
      this.type,
      this.data,
      this.valid = false,
      required this.errorMessage,
      required this.status});

  factory ActionSingleDataResponse.fromJsonString(
          String string, T Function(Map<String, dynamic>?) fromJson) =>
      ActionSingleDataResponse.fromJson(json.decode(string), fromJson);

  factory ActionSingleDataResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>?) fromJson) {
    return ActionSingleDataResponse(
      id: json['id'] as String,
      type: json['type'] as String,
      data: fromJson(json['data']),
      valid: json['valid'] as bool,
      status: json['valid'] && json['error'].isEmpty
          ? ResponseStatus.success
          : ResponseStatus.failed,
      errorMessage: json['error'] as String,
    );
  }
}
