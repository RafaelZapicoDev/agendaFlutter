import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/pages/busca.dart';

import 'package:recipes/View/viewResources/forms/cadastro_contato.dart';

import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

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
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Última interação",
                      style: TextStyle(
                          color: Color.fromARGB(255, 214, 178, 48),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 30, left: 20, right: 20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 90,
                          ),
                          Text(
                            "data",
                            style: TextStyle(fontSize: 30),
                          ),
                          Padding(padding: EdgeInsets.only(right: 240))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(23),
            alignment: Alignment.center,
            child: Column(
              children: [
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
                                    builder: (context) =>
                                        const CadastroContato()))
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
