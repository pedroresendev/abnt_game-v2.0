import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarTurmaController {
  updateTurma(Turma turma) async {
    await FirebaseFirestore.instance
        .collection("turma")
        .doc(turma.id)
        .update(turma.toFirestore());
  }
}
