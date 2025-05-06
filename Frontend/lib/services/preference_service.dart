import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String _keyTheme = 'themeMode';
  static const String _keyLanguage = 'language';
  static const String _keyIp = 'ipAddress';

  Future<void> setThemeMode(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, theme);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyTheme);
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, lang);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  Future<void> setIpAddress(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyIp, ip);
  }

  Future<String?> getIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyIp);
  }
}
