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
  final senha = TextEditingController();
  final senhaConfirm = TextEditingController();
  late bool termos = false;

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: senha.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
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
                SizedBox(
                  width: 400,
                  height: 300,
                  child: Image.asset(
                    'img/LOGO.png',
                    fit: BoxFit.contain,
                  ),
                ),
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
                            // cadastrarContato(),
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
