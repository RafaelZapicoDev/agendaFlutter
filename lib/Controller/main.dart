import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/Controller/login_verify.dart';

import 'package:recipes/View/viewResources/theme/n_tema.dart';
import 'package:recipes/View/viewResources/firebase_options.dart';

void main() async {
  //inicializando com o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      //mudança de temas
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
          home: const LoginVerify(),
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.currentTheme,
        );
      },
    );
  }
}
