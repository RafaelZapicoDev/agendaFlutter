class Contato {
  int id;
  String nome;
  String telefone;
  String email;
  String pais;
  String genero;
  DateTime nascimento;
  bool termos;

  Contato(
      {required this.id,
      required this.termos,
      required this.nome,
      required this.email,
      required this.pais,
      required this.genero,
      required this.nascimento,
      required this.telefone});
}
