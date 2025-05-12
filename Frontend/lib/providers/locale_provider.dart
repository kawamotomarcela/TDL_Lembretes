import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  late Locale _locale;

  Locale get locale => _locale;

  LocaleProvider(Locale initialLocale) {
    _locale = initialLocale;
  }

  Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', code);
    _locale = code == 'pt' ? const Locale('pt', 'BR') : Locale(code);
    notifyListeners();
  }
}

