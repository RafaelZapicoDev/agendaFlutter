import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/theme/estilo.dart';

//mudando o tema do app
class ThemeNotifier with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? temaEscuro : temaClaro;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
