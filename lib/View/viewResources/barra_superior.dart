import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/View/viewResources/n_tema.dart';

class Barrasuperior extends AppBar {
  final bool tema = false;

  Barrasuperior({super.key, required nome})
      : super(
            title: Text("$nome"),
            centerTitle: true,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
            actions: [
              Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.dark_mode_outlined),
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme();
                  },
                );
              }),
            ]);
}
