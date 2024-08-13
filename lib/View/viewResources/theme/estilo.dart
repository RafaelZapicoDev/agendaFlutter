import 'package:flutter/material.dart';

//padrões de tema do aplicativo

final ThemeData temaClaro = ThemeData(
    listTileTheme: const ListTileThemeData(
        style: ListTileStyle.list,
        textColor: Colors.black,
        iconColor: Color.fromARGB(255, 106, 148, 223)),
    dialogTheme: const DialogTheme(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 20)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 212, 222, 228),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 106, 153, 233),
        foregroundColor: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 255, 179, 0)));

final ThemeData temaEscuro = ThemeData(
  primaryColor: const Color.fromARGB(255, 155, 166, 185),
  scaffoldBackgroundColor: const Color.fromARGB(255, 61, 58, 73),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 40, 48, 58),
  ),
  colorScheme: const ColorScheme.dark(),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 6, 26, 61),
      foregroundColor: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white, backgroundColor: Colors.amber),
);
