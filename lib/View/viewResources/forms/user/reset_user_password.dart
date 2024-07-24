import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

// formulario para reset de senha usando email

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<StatefulWidget> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final email = TextEditingController();
  late bool termos = false;

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  void mensagemErro(FirebaseAuthException? e) {
    Widget mensagem;
    if (e != null) {
      mensagem =
          const Text("Um link de reset foi enviado para o email cadastrado!");
    } else {
      mensagem = const Text(
          "Algo deu errado, confira se digitou corretamente o email cadastrado!");
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

//metodo para enviar email de reset de senha
  Future resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      mensagemErro(null);
    } on FirebaseAuthException catch (e) {
      mensagemErro(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        //adiciona uma area pra aparecer a barra do sistema
        child: SingleChildScrollView(
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
                    width: 4300,
                    height: 400,
                    child: Image.asset(
                      'img/LOGO.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        "Insira seu email cadastrado, enviaremos um link para redefinição de senha!",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 20),
                      )
                    ],
                  ),
                  CustomTextFormField(
                    secret: false,
                    controller: email,
                    validatorMessage: "Insira um nome email válido!",
                    type: TextFormType.email,
                    labelText: "Email de Usuário",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.blueAccent),
                        onPressed: () => {
                              if (formKey.currentState!.validate())
                                {resetPassword(context)}
                            },
                        child: const SizedBox(
                          width: 200,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                "Enviar Email",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        ));
                  }),
                ],
              )),
        )),
      ),
    );
  }
}
