class Contato {
  int id;
  String nome;
  String numero;
  String email;
  String pais;
  String genero;
  bool termos;

  Contato(
      {required this.id,
      required this.termos,
      required this.nome,
      required this.email,
      required this.pais,
      required this.genero,
      required this.numero});
}
