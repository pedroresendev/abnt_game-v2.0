import 'package:cloud_firestore/cloud_firestore.dart';

class ClassificacaoController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRanking(String codigo) {
    var docs = FirebaseFirestore.instance
        .collection("aluno")
        .where("turma", isEqualTo: codigo)
        .orderBy("xpAtual", descending: true)
        .snapshots();
    return docs;
  }
}
