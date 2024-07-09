import 'package:flutter/material.dart';

class Barrasuperior extends AppBar {
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
        );
}
