import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilProfessor extends Perfil {
  List<Turma> turmas = [];
  Function? _notify;
  PerfilProfessor(User user)
      : super(
            id: user.uid,
            email: user.email!,
            nome: user.displayName!,
            fotoPerfil: user.photoURL);

  PerfilProfessor.fromFirestore(Map<String, Object?> data, User user,
      [this._notify])
      : super(
          email: user.email!,
          id: user.uid,
          nome: user.displayName!,
          fotoPerfil: user.photoURL,
        );

  @override
  getPerfil() async {
    var profData =
        await FirebaseFirestore.instance.collection("professor").doc(id).get();
    if (profData.data() != null) {
      turmas = profData.data()!["turmas"] ?? [];
    }
    (_notify != null) ? _notify!() : null;
  }

  @override
  toMap() {
    return {
      "nome": nome
    };
  }

  @override
  updateName(String nome) async{
    this.nome = nome;
    await updateFirestore();
  }

  @override
  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection("professor")
        .doc(id)
        .update(toMap());
  }

  getTurmas() async {
    turmas = [];
    await FirebaseFirestore.instance
        .collection("turma")
        .where("profID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        turmas.add(Turma.fromFirestore(doc));
      }
    });

    (_notify != null) ? _notify!() : null;
  }
}
