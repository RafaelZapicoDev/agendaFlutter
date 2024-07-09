import 'package:flutter/material.dart';
import 'package:recipes/View/busca.dart';

import 'package:recipes/View/viewResources/barra_superior.dart';
import 'package:recipes/View/viewResources/menu.dart';

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
        nome: "Agenda Contatos",
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 241, 208, 171),
            padding: const EdgeInsets.all(23),
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text(
                  "Seja bem vindo",
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 106, 153, 233)),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Busca()))
                          },
                      child: const SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              "Buscar Contatos",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ));
                }),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Busca()))
                          },
                      child: const SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.control_point_duplicate_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              "Cadastrar Contato",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ));
                })
              ],
            ),
          ),
        ],
      )),
    );
  }
}
