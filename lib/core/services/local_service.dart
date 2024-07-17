import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LocalService {
  final GetStorage _storage;

  const LocalService({required GetStorage storage}) : _storage = storage;

  final String _ignoredUsersKey = "ignored_users";

  List<String> readIgnoredUsers() {
    String? result = _storage.read(_ignoredUsersKey);
    if (result != null) {
      return List<String>.from(json.decode(result));
    } else {
      return <String>[];
    }
  }

  Future<void> addToIgnoredUsers(String authorName) async {
    List<String> result = readIgnoredUsers();
    result.add(authorName);
    await _storage.write(_ignoredUsersKey, json.encode(result));
  }
}
