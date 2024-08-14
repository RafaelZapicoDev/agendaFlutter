import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/Services/n_tema.dart';

class Barrasuperior extends AppBar {
  final String nome;

  Barrasuperior({super.key, required this.nome})
      : super(
          title: Text(nome),
          centerTitle: true,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          actions: [
            Builder(builder: (BuildContext context) {
              return Consumer<ThemeNotifier>(
                //lofica pra mudar o tema e icone do botão de trocar tema
                builder: (context, themeNotifier, _) => IconButton(
                  icon: themeNotifier.isDark
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.dark_mode_outlined),
                  onPressed: () {
                    themeNotifier.toggleTheme();
                  },
                ),
              );
            }),
          ],
        );
}
