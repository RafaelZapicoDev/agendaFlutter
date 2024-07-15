import 'package:recipes/Model/contato.dart';

class ContatoService {
  static List<Contato> contatos = [
    Contato(
        id: 1,
        termos: true,
        nome: "Teste",
        email: "teste@gmail.com",
        pais: "Brasil",
        genero: "Prefiro Não Responder",
        numero: "1234567890")
  ];

  List listarContato() {
    return contatos;
  }

  void cadastrar(Contato contato) {
    contatos.add(contato);
  }

  void editar(Contato contato) {
    contatos[contato.id - 1] = contato;
  }

  void deletar(Contato contato) {
    contatos.remove(contato);
  }
}
