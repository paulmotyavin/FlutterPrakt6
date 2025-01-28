import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeHelper with ChangeNotifier {
  static const String _themeData = 'data';
  bool _isDarkTheme = false;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme(_isDarkTheme ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> _saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeData, theme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString(_themeData);
    _isDarkTheme = savedTheme == 'dark';
    notifyListeners();
  }
}