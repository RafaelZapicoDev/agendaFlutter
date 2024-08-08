import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:recipes/Services/contato_service.dart';

import 'package:recipes/View/viewResources/pages/perfil_contatos.dart';
import 'package:recipes/View/viewResources/forms/contato/cadastro_contato.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

//pagina de busca de contatos
class Busca extends StatefulWidget {
  const Busca({super.key});

  @override
  State<StatefulWidget> createState() => BuscaState();
}

class BuscaState extends State<Busca> {
  ContatoService service = ContatoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Barrasuperior(
          nome: "Meus Contatos",
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CadastroContato()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: const MenuDrawer(),
        //monta a lista com base na lista de contatos retornada do service
        body: FutureBuilder(
            future: service.listarContatos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar contatos.'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Nenhum contato encontrado.'));
              } else {
                final contatos = snapshot.data.docs;
                logger.i(contatos);
                return ListView.builder(
                    itemCount: contatos.length,
                    itemBuilder: (context, index) {
                      final contato = contatos[index].data();
                      final contatoId = contatos[index].id;
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ListTile(
                            leading: const Icon(
                              Icons.person,
                              size: 33,
                            ),
                            title: Row(
                              children: [
                                Text(contato['Nome']),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20)),
                                Column(
                                  children: [
                                    Text(contato['Email']),
                                    Text(contato['Numero'])
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PerfilContatos(
                                              contatoId: contatoId,
                                            )));
                              },
                            ),
                          ));
                    });
              }
            }));
  }
}
