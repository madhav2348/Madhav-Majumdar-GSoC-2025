import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeMode _thememode = ThemeMode.light;
  ThemeMode get themeMode => _thememode;
  ThemeData _data = ThemeData.light();
  ThemeData get data => _data;

  ThemeData check() {
    Brightness brightness = PlatformDispatcher.instance.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    _thememode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _data = isDarkMode ? ThemeData.dark() : ThemeData.light();
    // notifyListeners();
    return _data;
  }

  void toggle(bool isDark) {
    _thememode = isDark ? ThemeMode.dark : ThemeMode.light;
    _data = isDark ? ThemeData.dark() : ThemeData.light();

    notifyListeners();
  }
}
