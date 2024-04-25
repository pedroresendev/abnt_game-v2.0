import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CodigoController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> setAluno([String? codigo]) async {
    if (codigo != null) {
      bool codigoExiste = await firestore
          .collection("turma")
          .doc(codigo)
          .get()
          .then((value) => value.exists);
      if (!codigoExiste) {
        throw Exception("Esse código não existe!");
      } else {
        await firestore
            .collection("aluno")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "nome": FirebaseAuth.instance.currentUser!.displayName,
          "imageURL": null,
          "melhorRanking": 0,
          "rankingAtual": 0,
          "xpAtual": 0,
          "xpColetado": 0,
          'turma': codigo
        });
      }
    } else {
      firestore
          .collection("aluno")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "nome": FirebaseAuth.instance.currentUser!.displayName,
        'turma': null,
        "imageURL": null,
        "melhorRanking": 0,
        "rankingAtual": 0,
        "xpAtual": 0,
        "xpColetado": 0,
      });
    }
  }
}
