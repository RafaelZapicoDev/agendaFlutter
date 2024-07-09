import 'package:recipes/Model/contato.dart';

class ContatoService {
  static List<Contato> contatos = [];

  List listarContato() {
    return contatos;
  }

  void cadastrar(Contato contato) {
    contatos.add(contato);
  }
}
