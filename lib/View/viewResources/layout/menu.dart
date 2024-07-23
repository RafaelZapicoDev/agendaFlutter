import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/Services/google_login.dart';
import 'package:recipes/View/viewResources/pages/busca.dart';
import 'package:recipes/View/viewResources/pages/home.dart';
import 'package:recipes/View/viewResources/pages/perfil_contatos.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final user = FirebaseAuth
      .instance.currentUser; //pega o usuario que ta logado no momento

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 106, 153, 233)),
              accountName: const Text("Nilou"),
              accountEmail: Text(user?.email ??
                  'Email não registrado'), //se tiver email do usuario
              // poe o email senao informa ao usuario
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("img/LOGO.png"),
                ),
              )),
          ListTile(
            title: const Text("Home"),
            subtitle: const Text("Página inicial"),
            leading: const Icon(Icons.home),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            title: const Text("Perfil"),
            subtitle: const Text("Página inicial"),
            leading: const Icon(Icons.person_pin_sharp),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerfilContatos(
                            id: 0,
                          )));
            },
          ),
          ListTile(
            title: const Text("Contatos"),
            subtitle: const Text("Gerenciar contatos"),
            leading: const Icon(Icons.people),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Busca()));
            },
          ),
          ListTile(
            title: const Text("Configurações"),
            subtitle: const Text("Preferências do sistema"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            title: const Text("Logout"),
            subtitle: const Text("Sair do sistema"),
            leading: const Icon(Icons.logout),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              AuthService().signOutFromGoogle(); //desloga e manda pro login
              // ps: se for do google ou não
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginVerify()));
            },
          ),
        ],
      ),
    );
  }
}
