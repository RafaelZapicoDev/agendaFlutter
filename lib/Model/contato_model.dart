import 'package:cloud_firestore/cloud_firestore.dart';

class Contato {
  final String email;
  final String nome;
  final String genero;
  final String pais;
  final String numero;
  final Timestamp ultimaIteracao;
  Contato(
      {required this.email,
      required this.nome,
      required this.genero,
      required this.pais,
      required this.numero,
      required this.ultimaIteracao});
}
