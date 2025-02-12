import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userStorageProvider = Provider((ref) => UserStorage());

class UserStorage {
  static const String userKey = 'user_key';

  static Future<void> saveUserString({required String username}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, username);
  }

  static Future<String> getUserString() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(userKey);
    return username ?? '';
  }
}
