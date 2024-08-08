import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/Model/contato.dart';

class ContatoService {
  final user = FirebaseAuth
      .instance.currentUser!.uid; //pega o usuário que esta logado no momento

  Future listarContatos() async {
    //retorna os contatos vinculados ao meu usuario
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .get();
  }

  Future listarContatosId(String contatoId) async {
    //retorna os contatos vinculados ao meu usuario
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .doc(contatoId)
        .get();
  }

  Future adicionarContato(Contato contato) async {
    //retorna os contatos vinculados ao meu usuario
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .add({
      'Email': contato.email,
      'Genero': contato.genero,
      'Nome': contato.nome,
      'Numero': contato.numero,
      'Pais': contato.pais,
    });
  }

  Future editarContato(Contato contato, String contatoId) async {
    //retorna os contatos vinculados ao meu usuario
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .doc(contatoId)
        .update({
      'Email': contato.email,
      'Genero': contato.genero,
      'Nome': contato.nome,
      'Numero': contato.numero,
      'Pais': contato.pais,
    });
  }

  Future removerContato(String contatoId) async {
    //remove o contato que possui o id passado da lista
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .doc(contatoId)
        .delete();
  }
}
