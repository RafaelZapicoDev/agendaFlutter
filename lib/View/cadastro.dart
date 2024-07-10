import 'package:flutter/material.dart';
import 'package:recipes/Model/contato.dart';
import 'package:recipes/Model/contato_service.dart';
import 'package:recipes/View/busca.dart';
import 'package:recipes/View/viewResources/barra_superior.dart';
import 'package:recipes/View/viewResources/input_text.dart';
import 'package:recipes/View/viewResources/menu.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Barrasuperior(nome: "Cadastro"),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InputText(controller: nome, label: "Nome"),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              InputText(controller: email, label: "Email"),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              InputText(controller: telefone, label: "Telefone"),
              const Padding(padding: EdgeInsets.only(bottom: 40)),
              Builder(builder: (BuildContext context) {
                return ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () => {
                          cadastrarContato(),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Busca())),
                        },
                    child: const SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                            size: 25,
                          ),
                          Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  void cadastrarContato() {
    ContatoService service = ContatoService();
    Contato contato = Contato(
        id: service.listarContato().length + 1,
        nome: nome.text,
        email: telefone.text,
        telefone: telefone.text);

    service.cadastrar(contato);
  }
}
