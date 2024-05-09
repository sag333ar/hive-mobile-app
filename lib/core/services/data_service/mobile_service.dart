import 'dart:convert';

import 'package:flutter/services.dart';

const String channel = 'app.the-hive-mobile/bridge';
const platform = MethodChannel(channel);


Future<String> evaluateJavaScriptFromPlatform(String jsCode) async {
  final String reqId = 'evaluateJavaScript${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('evaluateJavaScript', {
    'id': reqId,
    'jsCode': jsCode,
  });
  return response;  
}

Future<String> getAccountHistoryFromPlatform(
    String accountName, int startId, int limit, String filters) async {
  final String id = 'getAccountHistory${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getAccountHistory', {
    'id': id,
    'accountName': accountName,
    'startId': startId,
    'limit': limit,
    'filters': filters
  });
  return response;
}

Future<String> getHtmlFromPlatform(
  String inputString,
  int width,
) async {
  final String id =  'getHtml${DateTime.now().toIso8601String()}';
  var encodedString = base64.encode(utf8.encode(inputString));
  final response = await platform.invokeMethod('getHtml', {
    'id': id,
    'inputString': encodedString,
    'width': width,
  });
  return response;
}
