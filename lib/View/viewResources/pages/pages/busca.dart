import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:recipes/Services/contato_service.dart';
import 'package:recipes/View/viewResources/pages/pages/perfil_contatos.dart';
import 'package:recipes/View/viewResources/forms/contato/cadastro_contato.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

// Função para gerar cores pastéis
Color getRandomPastelColor() {
  final Random random = Random();

  final int red = 1200 + random.nextInt(136);
  final int green = 10 + random.nextInt(146);
  final int blue = 80 + random.nextInt(146);

  return Color.fromARGB(200, red, green, blue);
}

// Página de busca de contatos
class Busca extends StatefulWidget {
  const Busca({super.key});

  @override
  State<StatefulWidget> createState() => BuscaState();
}

class BuscaState extends State<Busca> {
  ContatoService service = ContatoService();
  bool filterFavorite = false;

  Future Busca() {
    if (filterFavorite) {
      return service.listarContatosFavorite();
    } else {
      return service.listarContatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Barrasuperior(
        nome: "Meus Contatos",
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        distance: 60,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  //método para navegação
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CadastroContato()));
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.filter_alt),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            child: filterFavorite
                ? const Icon(Icons.star_rounded)
                : const Icon(Icons.star_border_rounded),
            onPressed: () {
              setState(() {
                filterFavorite = !filterFavorite;
              });
            },
          ),
        ],
      ),

      drawer: const MenuDrawer(),

      // Monta a lista com base na lista de contatos retornada do service
      body: FutureBuilder(
        future: Busca(),
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

            return ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                final contato = contatos[index].data();
                final contatoId = contatos[index].id;
                return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(149, 255, 255, 255)),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 0, right: 5),
                    margin: const EdgeInsets.only(
                        left: 15, right: 10, bottom: 0, top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 75,
                          color: getRandomPastelColor(),
                        ),
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: 1,
                            leading: const CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Color.fromARGB(255, 170, 195, 240),
                              foregroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Icon(Icons.person_rounded),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  color: Colors.amber,
                                  icon: contato['Favorito']
                                      ? const Icon(Icons.star_rounded)
                                      : const Icon(Icons.star_border_rounded),
                                  onPressed: () {
                                    setState(() {
                                      contato['Favorito'] =
                                          !contato['Favorito'];
                                    });
                                    service.favoritaContato(contatoId);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                      Icons.keyboard_arrow_right_rounded),
                                  onPressed: () {
                                    Navigator.push(
                                        //método para navegação
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PerfilContatos(
                                                  contatoId: contatoId,
                                                )));
                                  },
                                ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      contato['Nome'],
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 63, 95),
                                          fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
