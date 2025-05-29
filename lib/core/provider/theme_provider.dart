import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String _darkKey = 'isDark';
  bool _isDark = false;
  late SharedPreferences _prefs;

  bool get isDark => _isDark;

  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isDark = _prefs.getBool(_darkKey) ?? false;
    notifyListeners();
  }

  Future<void> setDark() async {
    _isDark = true;
    await _prefs.setBool(_darkKey, true);
    notifyListeners();
  }

  Future<void> setLight() async {
    _isDark = false;
    await _prefs.setBool(_darkKey, false);
    notifyListeners();
  }
}
