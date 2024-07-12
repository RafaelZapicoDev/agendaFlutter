import 'package:flutter/material.dart';
import 'package:recipes/View/busca.dart';
import 'package:recipes/View/home.dart';
import 'package:recipes/View/perfil.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 106, 153, 233)),
              accountName: const Text("Nilou"),
              accountEmail: const Text("nilou@academya.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("img/nilou.jpg"),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ],
      ),
    );
  }
}
