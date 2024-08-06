import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipes/View/viewResources/form_widgets/google_button.dart';

import 'package:recipes/View/viewResources/form_widgets/text_form.dart';
import 'package:recipes/View/viewResources/forms/user/cadastro_user.dart';
import 'package:recipes/View/viewResources/forms/user/reset_user_password.dart';

//formulario login
class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<StatefulWidget> createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  final email = TextEditingController();
  final senha = TextEditingController();
  late bool termos = false;

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  //METODO QUE CHAMA O LOGIN NORMAL (EMAIL E SENHA)
  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: senha.text.trim())
        .then((e) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        //da um espacino pra considerar a barra de tarefas do celular
        child: SingleChildScrollView(
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
                  SizedBox(
                    width: 500,
                    height: 300,
                    child: Image.asset(
                      'img/LOGO.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  CustomTextFormField(
                    secret: false,
                    controller: email,
                    validatorMessage: "Insira um nome email válido!",
                    type: TextFormType.email,
                    labelText: "Email de Usuário",
                  ),
                  CustomTextFormField(
                    secret: true,
                    controller: senha,
                    validatorMessage: "Insira uma senha válida!",
                    type: TextFormType.text,
                    labelText: "Senha de Acesso",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Esqueceu a senha?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 200)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context, //manda pra resetar a senha ↓
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Recupere-a",
                          style: TextStyle(
                            color: Colors.amber[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          //ve se todos os formularios estao
                          //validados de acordo antes de deixar logar nesse trem
                          if (formKey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        child: const SizedBox(
                          width: 125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.login_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          backgroundColor: Colors.blueAccent[200],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CadastroUser(),
                            ),
                          );
                        },
                        child: const SizedBox(
                          width: 125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.arrow_circle_up,
                                color: Colors.white,
                                size: 35,
                              ),
                              Text(
                                "Cadastro",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                    width: 500,
                    child: Divider(
                      color: Color.fromARGB(255, 202, 204, 206),
                    ),
                  ),
                  const GoogleButton() //botao de login com google (logica separada)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
