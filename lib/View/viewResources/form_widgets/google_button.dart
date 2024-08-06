import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<DocumentSnapshot> getData() async {
    User loggedUser =
        FirebaseAuth.instance.currentUser!; //pega o usuario logado
    return FirebaseFirestore
        .instance //busca no banco se existem dados desse usuario
        .collection('users')
        .doc(loggedUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      onPressed: () async {
        await AuthService().signInWithGoogle();
        await getData().then((e) {
          //verifica se o usuario ja tem os dados completos

          if (e.data() != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginVerify(),
              ),
            );
          } else if (e.data() == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CompletaDados(),
              ),
            );
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
