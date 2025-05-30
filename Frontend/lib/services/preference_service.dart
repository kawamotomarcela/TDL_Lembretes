import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String _keyThemeMode = 'themeMode';
  static const String _keyLanguage = 'language';
  static const String _keyIpAddress = 'ipAddress';

  Future<void> setThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode);
  }

  Future<void> resetThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyThemeMode);
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, languageCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  Future<void> setIpAddress(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyIpAddress, ip);
  }

  Future<String?> getIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyIpAddress);
  }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
