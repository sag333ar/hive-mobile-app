import 'dart:convert';
import 'package:hive_mobile_app/core/utilities/enum.dart';

class ActionListDataResponse<T> {
  final List<T>? data;
  final bool valid;
  final String errorMessage;
  final ResponseStatus status;
  final bool isSuccess;

  ActionListDataResponse({
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
  final T? data;
  final bool valid;
  final String errorMessage;
  final ResponseStatus status;
  final bool isSuccess;

  ActionSingleDataResponse(
      {
      this.data,
      this.isSuccess = false,
      this.valid = false,
      required this.errorMessage,
      required this.status});

  factory ActionSingleDataResponse.fromJsonString(
          String string, T Function(Map<String, dynamic>) fromJson,{bool parseFromList = false}) =>
      ActionSingleDataResponse.fromJson(json.decode(string), fromJson,parseFromList: parseFromList);

  factory ActionSingleDataResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson,{bool parseFromList = false}) {
    return ActionSingleDataResponse(
      data: parseFromList ? fromJson(json['data'][0]) : fromJson(json['data']),
      valid: json['valid'] as bool,
      status: json['valid'] && json['error'].isEmpty
          ? ResponseStatus.success
          : ResponseStatus.failed,
      isSuccess: json['valid'] && json['error'].isEmpty,
      errorMessage: json['error'] as String,
    );
  }
}
