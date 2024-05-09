// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:js/js.dart';
import 'dart:js_util';

@JS('evaluateJavaScript')
external dynamic evaluateJavaScript(String jsCode);

Future<String> evaluateJavaScriptFromPlatform(String jsCode) async {
  var promise = evaluateJavaScript(jsCode);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getAccountHistory(accountName, startId, limit, filters);

Future<String> getAccountHistoryFromPlatform(
    String accountName, int startId, int limit, String filters) async {
  var promise = getAccountHistory(accountName, startId, limit, filters);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS('getHtml')
external dynamic getHtml(
  String inputString,
  int width,
);

Future<String> getHtmlFromPlatform(
  String inputString,
  int width,
) async {
  var promise = getHtml(base64.encode(utf8.encode(inputString)), width);
  var contentData = await promiseToFuture(promise);
  return contentData;
}
