enum FeedType { trending, hot, created }

enum AccountPostType {blog,posts,comments,replies}

enum FollowType {followers,following}

enum ResponseStatus { success, failed, unknown }

enum ViewState { loading, data, empty, error }

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values, {T? defaultValue}) {
  try {
    return values.firstWhere(
      (element) =>
          key.toLowerCase() == enumToString(element as Object).toLowerCase(),
    );
  } catch (e) {
    if (defaultValue == null) {
      throw 'Please assign default enum value incase theres a error';
    }
    return defaultValue;
  }
}
