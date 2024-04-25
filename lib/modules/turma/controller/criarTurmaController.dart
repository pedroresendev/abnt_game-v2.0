import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class CriarTurmaController {
  TextEditingController codigo = TextEditingController();
  TextEditingController nome = TextEditingController();

  criarTurma(Map<String, List<bool>> topicosAtivos) async {
    var turma = Turma(codigo.text, nome.text, topicosAtivos,
        FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection("turma")
        .doc(turma.id)
        .set(turma.toFirestore());
  }
}
