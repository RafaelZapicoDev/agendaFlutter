class Contato {
  int id;
  String nome;
  String numero;
  String email;
  String pais;
  String genero;
  String data;
  bool termos;

  Contato(
      {required this.id,
      required this.termos,
      required this.nome,
      required this.email,
      required this.pais,
      required this.genero,
      required this.data,
      required this.numero});
}
