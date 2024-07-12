import 'package:flutter/material.dart';
import 'package:recipes/View/busca.dart';
import 'package:recipes/View/viewResources/layout/barra_superior.dart';
import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

import 'package:recipes/View/viewResources/layout/menu.dart';

class Cadastro2 extends StatefulWidget {
  const Cadastro2({super.key});

  @override
  State<StatefulWidget> createState() => CadastroState();
}

class CadastroState extends State<Cadastro2> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final numero = TextEditingController();
  List<String> paises = ["Brasil", "Colombia", "Mexico"]; //substituir
  late String pais = '';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            key: formKey,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                CustomTextFormField(
                  controller: nome,
                  validatorMessage: "Insira um nome válido",
                  type: TextFormType.text,
                  labelText: "Nome Completo",
                ),
                CustomTextFormField(
                  controller: email,
                  validatorMessage: "Insira um email válido",
                  type: TextFormType.email,
                  labelText: "Email",
                ),
                CustomTextFormField(
                  controller: numero,
                  validatorMessage: "Insira um numero válido",
                  type: TextFormType.numero,
                  labelText: "Telefone / Celular",
                ),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: "País de Origem",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 98, 160, 190),
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  value: pais.isEmpty ? null : pais,
                  validator: (pais) {
                    if (pais == null || pais.isEmpty) {
                      return "Selecione seu país atual!";
                    }
                    return null;
                  },
                  hint: const Text("Selecione seu país"),
                  onChanged: (pais2) {
                    setState(() {
                      pais = pais2!;
                    });
                  },
                  items: paises.map<DropdownMenuItem<String>>((String pais) {
                    return DropdownMenuItem<String>(
                      value: pais,
                      child: Text(
                        pais,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () => {
                            // cadastrarContato(),
                            if (formKey.currentState!.validate())
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Busca())),
                              }
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
}
