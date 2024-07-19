import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/View/viewResources/form_widgets/check_box.dart';
import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

class CadastroUser extends StatefulWidget {
  const CadastroUser({super.key});

  @override
  State<StatefulWidget> createState() => CadastroUserState();
}

class CadastroUserState extends State<CadastroUser> {
  final email = TextEditingController();
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final telefone = TextEditingController();
  final List<String> generos = [
    "Feminino",
    "Masculino",
    "Prefiro não responder"
  ];
  String? generoSelecionado;
  final senha = TextEditingController();
  final senhaConfirm = TextEditingController();
  late bool termos = false;

  @override
  void dispose() {
    email.dispose();
    nome.dispose();
    senha.dispose();
    telefone.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: senha.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> datePicker() async {
      DateTime? data = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (data != null) {
        setState(() {
          dataNascimento.text = "${data.day}/${data.month}/${data.year}";
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Já possui uma conta?",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    const Flexible(
                        child: FractionallySizedBox(
                      widthFactor: 1,
                    )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginVerify()));
                        },
                        child: Text(
                          "Entre no sistema",
                          style: TextStyle(
                              color: Colors.amber[700],
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
                CustomTextFormField(
                  controller: email,
                  validatorMessage: "Insira um email válido",
                  type: TextFormType.email,
                  labelText: "Email",
                ),
                CustomTextFormField(
                  controller: nome,
                  validatorMessage: "Insira um nome válido",
                  type: TextFormType.text,
                  labelText: "Nome Completo",
                ),
                CustomTextFormField(
                  controller: dataNascimento,
                  validatorMessage: "Insira uma data válida",
                  onTapius: () {
                    datePicker();
                  },
                  type: TextFormType.text,
                  labelText: "Aniversário",
                  readOnly: true,
                ),
                CustomTextFormField(
                  controller: telefone,
                  validatorMessage: "Insira um número válido",
                  type: TextFormType.numero,
                  labelText: "Telefone para contato",
                ),
                CustomTextFormField(
                  controller: senha,
                  validatorMessage: "Insira uma senha válida",
                  type: TextFormType.text,
                  labelText: "Senha",
                  obscure: true,
                ),
                CustomTextFormField(
                  controller: senhaConfirm,
                  validatorMessage: "Insira uma senha válida",
                  type: TextFormType.text,
                  labelText: "Confirmar senha",
                  obscure: true,
                ),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: "Gênero",
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
                  value: generoSelecionado,
                  validator: (genero) {
                    if (genero == null || genero.isEmpty) {
                      return "Responda o campo acima!";
                    }
                    return null;
                  },
                  hint: const Text("Selecione seu Gênero"),
                  onChanged: (String? newValue) {
                    setState(() {
                      generoSelecionado = newValue;
                    });
                  },
                  items: generos.map<DropdownMenuItem<String>>((String genero) {
                    return DropdownMenuItem<String>(
                      value: genero,
                      child: Text(
                        genero,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
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
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () => {
                            if (formKey.currentState!.validate())
                              {
                                signUp(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginVerify())),
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
                              "Cadastrar-se",
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
