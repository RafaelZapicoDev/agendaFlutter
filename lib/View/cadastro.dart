import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:recipes/Model/contato.dart';
import 'package:recipes/Model/contato_service.dart';
import 'package:recipes/View/busca.dart';
import 'package:recipes/View/viewResources/barra_superior.dart';
import 'package:recipes/View/viewResources/form_widgets/check_box.dart';
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
  bool termos = false;
  DateTime? nascimento;
  DateTime maioridade = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  final telefone = TextEditingController();
  String pais = '';
  List<String> paises = ["Brasil", "Colombia", "Mexico"];
  RadioGroupController genero = RadioGroupController();

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
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  validator: (String? nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Insira seu nome!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Nome Completo",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 98, 160, 190)),
                      ),
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 98, 160, 190)),
                      ),
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                  validator: (email) {
                    if (email == null ||
                        !EmailValidator.validate(email) ||
                        !email.contains("@")) {
                      return "Insira um email válido!";
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Telefone / Celular",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 98, 160, 190)),
                      ),
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                  validator: (numero) {
                    if (double.tryParse(numero!) == null) {
                      return "Isso é um NUMERO?!";
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: "País de Origem",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 98, 160, 190)),
                      ),
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                  value: pais,
                  validator: (pais) {
                    if (pais == null || pais.isEmpty) {
                      return "Selecione seu país atual!";
                    }
                    return null;
                  },
                  hint: const Text("Selecione seu país"),
                  onChanged: (pais2) {
                    setState(
                      () {
                        pais = pais2!;
                      },
                    );
                  },
                  items: paises.map<DropdownMenuItem<String>>((String pais) {
                    return DropdownMenuItem<String>(
                      value: pais,
                      child: Text(pais),
                    );
                  }).toList(),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                RadioGroup(
                  indexOfDefault: 2,
                  controller: genero,
                  values: const [
                    "Feminino",
                    "Masculino",
                    "Prefiro não responder"
                  ],
                  orientation: RadioGroupOrientation.horizontal,
                  decoration: const RadioGroupDecoration(
                    spacing: 10.0,
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                    ),
                    activeColor: Colors.amber,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                // CalendarDatePicker(
                //   lastDate: maioridade,
                //   initialDate: DateTime(1900, 1, 1),
                //   firstDate: DateTime(1900, 1, 1),
                // ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                CheckboxFormField(
                  title: const Text(
                    "Li e concordo com os termos de uso",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onSaved: (value) => {
                    setState(() {
                      termos = value ?? false;
                    })
                  },
                  validator: (termos) {
                    if (termos == false) {
                      return "É preciso concordar para validar seu cadastro!";
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () => {
                            // cadastrarContato(),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   void cadastrarContato() {
//     ContatoService service = ContatoService();
//     Contato contato = Contato(
//         id: service.listarContato().length + 1,
//         nome: nome.text,
//         email: email.text,
//         telefone: telefone.text,
//         pais: pais,
//         genero: genero.toString(),
//         termos: termos,
//         nascimento: null);
//     service.cadastrar(contato);
//   }
// }
}
