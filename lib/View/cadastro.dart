import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/barra_superior.dart';
import 'package:recipes/View/viewResources/menu.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Barrasuperior(nome: "Cadastro"),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          child: const Text("ok"),
        ),
      ),
    );
  }
}
