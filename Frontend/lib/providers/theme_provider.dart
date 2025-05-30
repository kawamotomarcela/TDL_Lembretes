import 'package:flutter/material.dart';
import '../../../services/preference_service.dart'; 

class ThemeProvider extends ChangeNotifier {
  final PreferenceService _preferenceService = PreferenceService();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final themeString = await _preferenceService.getThemeMode() ?? 'system';

    switch (themeString) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setTheme(String mode) async {
    await _preferenceService.setThemeMode(mode);

    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> resetThemeToDefault() async {
    await _preferenceService.resetThemeMode();
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}
