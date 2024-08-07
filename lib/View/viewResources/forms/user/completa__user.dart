import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/View/viewResources/form_widgets/check_box.dart';
import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

class CompletaDados extends StatefulWidget {
  const CompletaDados({super.key});

  @override
  State<CompletaDados> createState() => _CompletaDadosState();
}

class _CompletaDadosState extends State<CompletaDados> {
  // Controladores
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
  bool termos = false;

  // Dispose
  @override
  void dispose() {
    email.dispose();
    nome.dispose();
    dataNascimento.dispose();
    telefone.dispose();
    super.dispose();
  }

  // Pega o usuário logado
  final user = FirebaseAuth.instance.currentUser;

  // Método para gravar os dados adicionais do usuário
  Future addUserDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'nome': nome.text,
      'email': email.text,
      'dataNascimento': dataNascimento.text,
      'genero': generoSelecionado,
      'telefone': telefone.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Abre o datepicker e seta a data escolhida
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
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Complete seu cadastro para prosseguir",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
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
                  onSaved: (value) {
                    setState(() {
                      termos = value ?? false;
                    });
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
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await addUserDetails().then((e) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginVerify(),
                            ),
                          );
                        });
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
                            "Concluído",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
