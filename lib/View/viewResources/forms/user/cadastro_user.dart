import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/View/viewResources/form_widgets/check_box.dart';
import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

//formulario para cadastro de novo usuario

class CadastroUser extends StatefulWidget {
  const CadastroUser({super.key});

  @override
  State<StatefulWidget> createState() => CadastroUserState();
}

class CadastroUserState extends State<CadastroUser> {
  //controlers de informação
  final email = TextEditingController();
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final telefone = TextEditingController();
  final List<String> generos = [
    "Feminino",
    "Masculino",
    "Prefiro não responder"
  ];
  String generoSelecionado = "Prefiro não responder";
  final senha = TextEditingController();
  final senhaConfirm = TextEditingController();
  late bool termos = false;

//dispose desfaz da memoria alocada pra essas variaveis quando nao estao sendo mais usadas
  @override
  void dispose() {
    email.dispose();
    nome.dispose();
    senha.dispose();
    telefone.dispose();
    super.dispose();
  }

//método para cadastrar
  Future signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );

    if (senha.text.trim() == senhaConfirm.text.trim()) {
      //CRIANDO E LOGANDO O USUARIO

      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: senha.text.trim());

        //ADICIONANDO INFORMAÇÕES AO USUARIO
        addUserDetails(user.user!.uid, nome.text, email.text,
                dataNascimento.text, generoSelecionado, telefone.text)
            .then((e) {
          Navigator.of(context).pop();
        });
      } on FirebaseAuthException catch (e) {
        mensagemErro(e);
      }
    }
  }

  //mensagem de erro
  void mensagemErro(FirebaseAuthException? e) {
    Widget mensagem;
    if (e?.code == 'email-already-in-use') {
      mensagem = const Text("Erro, essa conta já foi cadastrada!");
    } else {
      mensagem = const Text("Ocorreu um erro inesperado");
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [mensagem],
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.amber),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          );
        });
  }

//metodo pra gravar os dados adicionais do usuario
  Future addUserDetails(
    String userId,
    String nome,
    String email,
    String dataNascimento,
    String genero,
    String telefone,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'nome': nome,
      'email': email,
      'dataNascimento': dataNascimento,
      'genero': genero,
      'telefone': telefone,
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//abre o datepicker e seta a data escolhida
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
                  secret: false,
                ),
                CustomTextFormField(
                  controller: nome,
                  secret: false,
                  validatorMessage: "Insira um nome válido",
                  type: TextFormType.text,
                  labelText: "Nome Completo",
                ),
                CustomTextFormField(
                  secret: false,
                  controller: dataNascimento,
                  validatorMessage: "Insira uma data válida",
                  onTapius: () {
                    // chama o metodo de abri o calendario
                    datePicker();
                  },
                  type: TextFormType.text,
                  labelText: "Aniversário",
                  readOnly: true,
                ),
                CustomTextFormField(
                  secret: false,
                  controller: telefone,
                  validatorMessage: "Insira um número válido",
                  type: TextFormType.numero,
                  labelText: "Telefone para contato",
                ),
                CustomTextFormField(
                  secret: true,
                  controller: senha,
                  validatorMessage: "Insira uma senha válida",
                  type: TextFormType.password,
                  labelText: "Senha",
                ),
                CustomTextFormField(
                  secret: true,
                  controller: senhaConfirm,
                  validatorMessage: "Insira uma senha válida",
                  type: TextFormType.password,
                  labelText: "Confirmar senha",
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
                      generoSelecionado = newValue!;
                    });
                  },
                  items: generos.map<DropdownMenuItem<String>>((String genero) {
                    // coloca os itens do dropdown com base na lista de
                    // generos que eu coloquei la em cima
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
                  // cadastra e manda pra verificar o login
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 30, right: 30),
                        backgroundColor: Colors.amber,
                        shape: const ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
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
