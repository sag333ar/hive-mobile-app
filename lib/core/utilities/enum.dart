// ignore_for_file: constant_identifier_names

enum FeedType { trending, hot, created }

enum AccountPostType { blog, posts, comments, replies }

enum FollowType { followers, following }

enum ResponseStatus { success, failed, unknown }

enum ViewState { loading, data, empty, error }

enum AccountHistoryType {
  claim_reward_balance,
  cancel_transfer_from_savings,
  withdraw_vesting,
  transfer_to_vesting,
  transfer_to_savings,
  transfer_from_savings,
  transfer,
  producer_reward,
  interest
}

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
