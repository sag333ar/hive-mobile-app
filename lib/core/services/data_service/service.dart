Future<String> evaluateJavaScriptFromPlatform(String jsCode) {
  return _error();
}

Future<String> getAccountHistoryFromPlatform(
    String accountName, int startId, int limit, String filters) {
  return _error();
}

Future<String> getHtmlFromPlatform(
  String inputString,
  int width,
){
  return _error();
}

Future<String> _error() {
  return Future.value('error');
}
