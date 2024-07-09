import 'package:recipes/Model/contato.dart';

class ContatoService {
  List listarContato() {
    List<Contato> contatos = [
      Contato(
          id: 1,
          nome: "pessoa1",
          email: "exemplo@gmail.com",
          telefone: "12345670"),
      Contato(
          id: 2,
          nome: "pessoa2",
          email: "exemplo@outlook.com",
          telefone: "12345678")
    ];
    return contatos;
  }

  // void cadastrar(Contato contato) {
  //   contatos.add(contato);
  // }
}
