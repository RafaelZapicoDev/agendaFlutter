import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/View/home.dart';

import 'package:recipes/View/viewResources/n_tema.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: "Agenda",
          home: const Home(),
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.currentTheme,
        );
      },
    );
  }
}
