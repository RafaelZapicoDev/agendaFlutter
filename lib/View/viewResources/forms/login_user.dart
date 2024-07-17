import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/pages/home.dart';
import 'package:recipes/View/viewResources/form_widgets/text_form.dart';

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

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), password: senha.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
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
                      fit: BoxFit.cover,
                    ),
                  ),

                  CustomTextFormField(
                    controller: email,
                    validatorMessage: "Insira um nome email válido!",
                    type: TextFormType.email,
                    labelText: "Email de Usuário",
                  ),
                  CustomTextFormField(
                    obscure: true,
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
                          onPressed: () {},
                          child: Text(
                            "Recupere-a",
                            style: TextStyle(
                                color: Colors.amber[700],
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () => {
                              // cadastrarContato(),
                              if (formKey.currentState!.validate())
                                {
                                  signIn()
                                  // cadastrar(),
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const Home())),
                                }
                            },
                        child: const SizedBox(
                          width: 200,
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
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        ));
                  }),
                  // CheckboxFormField(
                  //   title: const Text(
                  //     "Manter-me conectado",
                  //     style: TextStyle(color: Colors.blueAccent),
                  //   ),
                  //   onSaved: (value) => {
                  //     setState(() {
                  //       termos = value ?? false;
                  //     })
                  //   },
                  // ),
                ],
              )),
        )),
      ),
    );
  }
}
