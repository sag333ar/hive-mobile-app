enum FeedType { trending, hot, created }

enum ResponseStatus { success, failed, unknown }

enum ViewState { loading, data, empty, error }

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) {
  return values.firstWhere(
    (element) =>
        key.toLowerCase() == enumToString(element as Object).toLowerCase(),
  );
}
