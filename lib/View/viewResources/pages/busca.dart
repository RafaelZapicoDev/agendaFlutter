import 'package:flutter/material.dart';
import 'package:recipes/Model/contato.dart';
import 'package:recipes/Model/contato_service.dart';

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
        body: ListView.builder(
            itemCount: service.listarContato().length,
            itemBuilder: (BuildContext context, int index) {
              Contato contato = service.listarContato().elementAt(index);

              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber),
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      size: 33,
                    ),
                    title: Row(
                      children: [
                        Text(contato.nome),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20)),
                        Column(
                          children: [Text(contato.email), Text(contato.numero)],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PerfilContatos(id: contato.id)));
                      },
                    ),
                  ));
            }));
  }
}
