import 'package:flutter/material.dart';
import 'package:recipes/Model/contato.dart';
import 'package:recipes/Model/contato_service.dart';
import 'package:recipes/View/busca.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/layout/menu.dart';

class Perfil extends StatelessWidget {
  Perfil({super.key, required this.id});

  final int id;

  final ContatoService service = ContatoService();

  @override
  Widget build(BuildContext context) {
    Contato contato = service.listarContato().elementAt(id - 1);
    return Scaffold(
      appBar: Barrasuperior(nome: "Perfil"),
      drawer: const MenuDrawer(),
      body: Container(
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
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contato.nome,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      letterSpacing: 1,
                      wordSpacing: 8,
                      fontWeight: FontWeight.w500),
                )
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
                  "Email: ${contato.email}",
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
                  "Telefone: ${contato.numero}",
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.video_call,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Busca()));
        },
        backgroundColor: Colors.amber[600],
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
