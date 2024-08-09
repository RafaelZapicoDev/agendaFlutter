import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:recipes/Model/contato.dart';
import 'package:recipes/Services/contato_service.dart';
import 'package:recipes/View/viewResources/forms/contato/editar_contato.dart';
import 'package:recipes/View/viewResources/pages/busca.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

class PerfilContatos extends StatelessWidget {
  PerfilContatos({super.key, required this.contatoId});

  final String contatoId;
  final ContatoService service = ContatoService();

  @override
  Widget build(BuildContext context) {
    final contatoFuture = service.listarContatosId(contatoId);

    return Scaffold(
      appBar: Barrasuperior(nome: "Perfil"),
      drawer: const MenuDrawer(),
      body: FutureBuilder(
        future: contatoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar dados."));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Nenhum dado encontrado."));
          } else {
            final contato = snapshot.data.data() as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 90,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contato['Nome'] ?? 'Nome não disponível',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          letterSpacing: 1,
                          wordSpacing: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  const FractionallySizedBox(
                    widthFactor: 1.05,
                    child: Divider(
                      color: Colors.amber,
                      height: 5,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email: ${contato['Email'] ?? 'Email não disponível'}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(204, 68, 137, 255),
                          letterSpacing: 1,
                          wordSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Telefone: ${contato['Numero'] ?? 'Número não disponível'}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(204, 68, 137, 255),
                          letterSpacing: 1,
                          wordSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gênero: ${contato['Genero'] ?? 'Gênero não disponível'}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(204, 68, 137, 255),
                          letterSpacing: 1,
                          wordSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "País: ${contato['Pais'] ?? 'País não disponível'}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(204, 68, 137, 255),
                          letterSpacing: 1,
                          wordSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 45)),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        distance: 60,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            child: const Icon(Icons.delete_outline),
            onPressed: () {
              service.removerContato(contatoId);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Busca()),
              );
            },
          ),
        ],
      ),
    );
  }
}
