import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:intl/intl.dart'; // Adicione essa linha
import 'package:cloud_firestore/cloud_firestore.dart'; // Adicione essa linha
import 'package:recipes/Services/contato_service.dart';

import 'package:recipes/View/viewResources/forms/contato/editar_contato.dart';

import 'package:recipes/View/viewResources/pages/pages/busca.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

class PerfilContatos extends StatelessWidget {
  PerfilContatos({super.key, required this.contatoId});

  final String contatoId;
  final ContatoService service = ContatoService();

  @override
  Widget build(BuildContext context) {
    final contatoFuture = service.listarContatosId(contatoId);

    //pop up para excluir contato
    void popUp() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "Tem certeza que deseja excluir o contato da sua agenda XXXX ?",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      backgroundColor: Colors.redAccent,
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      service.removerContato(contatoId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Busca()));
                    },
                    child: const Text("Excluir"))
              ],
            );
          });
    }

    return Scaffold(
      //botao de ações do contato
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        distance: 70,
        type: ExpandableFabType.side,
        children: [
          FloatingActionButton.small(
            backgroundColor: const Color.fromARGB(255, 62, 189, 100),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarContato(id: contatoId)),
              );
            },
            child: const Icon(Icons.phone_enabled_rounded),
          ),
          FloatingActionButton.small(
            backgroundColor: const Color.fromARGB(255, 62, 189, 100),
            child: const Icon(Icons.messenger_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarContato(id: contatoId)),
              );
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarContato(id: contatoId)),
              );
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.share),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarContato(id: contatoId)),
              );
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarContato(id: contatoId)),
              );
            },
          ),
          FloatingActionButton.small(
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.delete_outline),
            onPressed: () {
              popUp();
            },
          ),
        ],
      ),

      //layout basico
      appBar: Barrasuperior(nome: "Perfil"),
      drawer: const MenuDrawer(),

      //
      body: FutureBuilder(
        future: contatoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar dados."));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Nenhum dado encontrado."));
          } else {
            final contato = snapshot.data.data() as Map<String, dynamic>;

            // Converte o timestamp e formata a data
            Timestamp timestamp = contato['Ultima Interacao'];
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat('d MMMM y').format(dateTime);

            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      height: 150,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 55,
                            left: 155,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          contato['Nome'].toString(),
                                          style: const TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 30),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 15)),
                                        IconButton(
                                            iconSize: 30,
                                            style: IconButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                foregroundColor: Colors.white),
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.tag_rounded,
                                            )),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 5)),
                                      ],
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 5)),
                                    Row(
                                      children: [
                                        Text(
                                          "Visto por último em $formattedDate",
                                          style: const TextStyle(
                                              color: Colors.blueGrey),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 50,
                      bottom: 0,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            minRadius: 55,
                            backgroundColor: Color.fromARGB(255, 180, 205, 252),
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.person_rounded,
                                size: 90,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              minRadius: 5,
                              backgroundColor:
                                  Color.fromARGB(255, 237, 241, 248),
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 450,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 23)),
                      const FractionallySizedBox(
                        widthFactor: 1,
                        child: Divider(
                          color: Color.fromARGB(100, 96, 125, 139),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 43)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Nome completo :",
                            style: TextStyle(
                                color: Color.fromARGB(228, 56, 77, 87),
                                fontSize: 20),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(contato['Nome'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 88, 115, 128),
                                  fontSize: 20))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Email de contato :",
                            style: TextStyle(
                                color: Color.fromARGB(228, 56, 77, 87),
                                fontSize: 20),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(contato['Email'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 88, 115, 128),
                                  fontSize: 20))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Número para contato :",
                            style: TextStyle(
                                color: Color.fromARGB(228, 56, 77, 87),
                                fontSize: 20),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(contato['Numero'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 88, 115, 128),
                                  fontSize: 20))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Genero :",
                            style: TextStyle(
                                color: Color.fromARGB(228, 56, 77, 87),
                                fontSize: 20),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(contato['Genero'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 88, 115, 128),
                                  fontSize: 20))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "País atual :",
                            style: TextStyle(
                                color: Color.fromARGB(228, 56, 77, 87),
                                fontSize: 20),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(contato['Pais'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 88, 115, 128),
                                  fontSize: 20))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
