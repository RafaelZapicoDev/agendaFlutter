import 'package:flutter/material.dart';

ThemeData estilo() {
  ThemeData base = ThemeData.dark();
  return base.copyWith(
      primaryColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.blueGrey[50],
      drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(95, 97, 148, 207)),
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 106, 153, 233),
          foregroundColor: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 241, 167, 69)));
}
