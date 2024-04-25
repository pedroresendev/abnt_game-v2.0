abstract class Perfil {
  String nome;
  String email;
  String? fotoPerfil;
  String id;

  Perfil(
      {required this.nome,
      required this.email,
      required this.id,
      this.fotoPerfil});

  getPerfil();
  toMap();
  updateFirestore();
  updateName(String nome);
}
