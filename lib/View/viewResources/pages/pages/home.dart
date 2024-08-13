import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/pages/pages/busca.dart';

import 'package:recipes/View/viewResources/forms/contato/cadastro_contato.dart';

import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

//pagina inicial do aplicativo

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Barrasuperior(
        nome: "Starmail Agenda",
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 350,
            width: 475,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
          ),
          Wrap(
            runSpacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      backgroundColor: const Color.fromARGB(255, 233, 192, 42),
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Busca()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.view_agenda),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(
                          "Meus Contatos",
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      backgroundColor: Colors.blueAccent,
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CadastroContato()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(
                          "Novo Contato",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
