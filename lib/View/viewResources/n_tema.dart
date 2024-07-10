import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/estilo.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? temaEscuro : temaClaro;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
