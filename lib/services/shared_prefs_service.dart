import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static Future<void> saveUserData({
    required String name,
    required int age,
    required String condition,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setInt('age', age);
    await prefs.setString('condition', condition);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? '',
      'age': prefs.getInt('age') ?? 0,
      'condition': prefs.getString('condition') ?? '',
    };
  }

  static Future<bool> isUserOnboarded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username');
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Theme
  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', isDark);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_mode') ?? false;
  }

  // Notifications
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }

  static Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  // Daily log reminder time (as string, e.g. "08:00")
  static Future<void> setLogReminderTime(String time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('log_reminder_time', time);
  }

  static Future<String> getLogReminderTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('log_reminder_time') ?? "08:00";
  }
}
