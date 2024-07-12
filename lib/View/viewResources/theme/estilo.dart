import 'package:flutter/material.dart';

final ThemeData temaClaro = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey[50],
    drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(95, 97, 148, 207)),
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 106, 153, 233),
        foregroundColor: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 255, 179, 0)));

final ThemeData temaEscuro = ThemeData(
  primaryColor: const Color.fromARGB(255, 155, 166, 185),
  scaffoldBackgroundColor: const Color.fromARGB(255, 61, 58, 73),
  drawerTheme:
      const DrawerThemeData(backgroundColor: Color.fromARGB(95, 0, 0, 0)),
  colorScheme: const ColorScheme.dark(),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 6, 26, 61),
      foregroundColor: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 255, 179, 0)),
);
