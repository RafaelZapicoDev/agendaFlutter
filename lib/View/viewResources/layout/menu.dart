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
          const DrawerHeader(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 102, 163, 243)),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("img/sample.jpg"),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  "Exemplo Usuário",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Text(
                  "@nilou.example",
                  style: TextStyle(color: Color.fromARGB(149, 255, 255, 255)),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ListTile(
            hoverColor: const Color.fromARGB(255, 246, 246, 248),
            title: const Text("Perfil"),
            subtitle: const Text("Página inicial"),
            leading: const Icon(Icons.person),
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
            hoverColor: const Color.fromARGB(255, 246, 246, 248),
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
            hoverColor: const Color.fromARGB(255, 246, 246, 248),
            title: const Text("Contatos"),
            subtitle: const Text("Gerenciar contatos"),
            leading: const Icon(Icons.people),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Busca()));
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const FractionallySizedBox(
            widthFactor: 0.9,
            child: Divider(
              height: 1.2,
              color: Color.fromARGB(61, 162, 173, 179),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          ListTile(
            hoverColor: const Color.fromARGB(255, 246, 246, 248),
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
            hoverColor: const Color.fromARGB(255, 246, 246, 248),
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
