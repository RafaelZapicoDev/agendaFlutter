import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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
        distance: 60,
        type: ExpandableFabType.up,
        children: [
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
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 2,
                              left: 175,
                              right: 0,
                              child: Text(
                                contato['Nome'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 77, 101, 112),
                                    fontSize: 36),
                              )),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 30,
                      bottom: -50,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            minRadius: 60,
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
                    )
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
