import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/Model/contato_model.dart';

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

  Future listarContatosFavorite() async {
    //retorna os contatos vinculados ao meu usuario
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .orderBy('Favorito')
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
      'Ultima Interacao': contato.ultimaIteracao,
      'Favorito': contato.isFavorito
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
      'Ultima Interacao': contato.ultimaIteracao,
    });
  }

  //favorita ou n um contato
  Future<void> favoritaContato(String contatoId) async {
    DocumentReference contatoRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('contatos')
        .doc(contatoId);
    DocumentSnapshot contatoSnapshot = await contatoRef.get();
    bool atualFavorito = contatoSnapshot.get('Favorito');
    await contatoRef.update({'Favorito': !atualFavorito});
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
