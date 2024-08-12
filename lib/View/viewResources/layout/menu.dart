import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recipes/Controller/login_verify.dart';
import 'package:recipes/Services/google_login.dart';
import 'package:recipes/View/viewResources/pages/pages/busca.dart';
import 'package:recipes/View/viewResources/pages/pages/home.dart';
import 'package:recipes/View/viewResources/pages/pages/perfil_contatos.dart';

Logger logger = Logger();

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final user = FirebaseAuth
      .instance.currentUser!.uid; // Pega o usuário que está logado no momento

  // PROVISORIO INFO MENU
  late DocumentSnapshot<Map<String, dynamic>> userSnapshot;

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocId() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    userSnapshot = snapshot;
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 102, 163, 243)),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.amberAccent,
                  )),
                );
              } else if (snapshot.hasError) {
                return const DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 102, 163, 243)),
                  child: Center(child: Text('Erro ao carregar dados')),
                );
              } else if (snapshot.hasData && snapshot.data!.exists) {
                final userData = snapshot.data!.data();
                logger.i(userData);
                final userName = userData?['nome'] ?? 'Usuário';
                final userEmail = userData?['email'] ?? 'Email';

                return DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 102, 163, 243)),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("img/sample.jpg"),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        userName,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Text(
                        userEmail,
                        style: const TextStyle(
                            color: Color.fromARGB(149, 255, 255, 255)),
                      ),
                    ],
                  ),
                );
              } else {
                return const DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 102, 163, 243)),
                  child: Center(child: Text('Dados não encontrados')),
                );
              }
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // ListTile(
          //   hoverColor: const Color.fromARGB(255, 246, 246, 248),
          //   title: const Text("Perfil"),
          //   subtitle: const Text("Página inicial"),
          //   leading: const Icon(Icons.person),
          //   trailing: const Icon(Icons.arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => PerfilContatos(
          //                   id: 0,
          //                 )));
          //   },
          // ),
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
              AuthService().signOutFromGoogle(); // Desloga e manda para o login
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
