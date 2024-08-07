import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/Services/google_login.dart';
import 'package:recipes/View/viewResources/forms/user/completa__user.dart';

Logger logger = Logger();

//botao de login do google
class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      onPressed: () async {
        await AuthService().signInWithGoogle().then((e) {
          //logando com o google
          if (e!.additionalUserInfo!.isNewUser) {
            //se for o primeiro acesso do usuario
            Navigator.push(
                context, //manda para a pagina de completar os dados
                MaterialPageRoute(builder: (context) => const CompletaDados()));
          } else {
            Navigator.push(
                context, //manda para a pagina de completar os dados
                MaterialPageRoute(builder: (context) => const LoginVerify()));
          }
        });
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.google,
            color: Colors.redAccent,
            size: 32,
          ),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            "Continue com Google",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 30)),
        ],
      ),
    );
  }
}
