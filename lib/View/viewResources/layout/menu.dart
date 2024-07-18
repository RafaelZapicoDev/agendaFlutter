import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/pages/busca.dart';
import 'package:recipes/View/viewResources/pages/home.dart';
import 'package:recipes/View/viewResources/pages/perfil.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 106, 153, 233)),
              accountName: const Text("Nilou"),
              accountEmail: Text(user?.email ?? 'No email available'),
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
                      builder: (context) => Perfil(
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
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
