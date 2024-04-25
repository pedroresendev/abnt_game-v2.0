import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/modules/perfil/models/perfilProfessor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/perfil.dart';

class PerfilProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PerfilTipo? tipo;
  Perfil? perfilAtual;

  logout() async {
    tipo = null;
    perfilAtual = null;
    _auth.signOut();
  }

  Future<PerfilTipo?> getUser() async {
    if (_auth.currentUser != null) {
      DocumentSnapshot alunoCheck = await FirebaseFirestore.instance
          .collection("aluno")
          .doc(_auth.currentUser!.uid)
          .get();

      if (alunoCheck.exists) {
        tipo = PerfilTipo.aluno;
        perfilAtual = PerfilAluno.fromFirestore(
            alunoCheck.data() as Map<String, Object?>,
            FirebaseAuth.instance.currentUser!)
          ..listenData();
          await (perfilAtual as PerfilAluno).getTurma();
      } else {
        DocumentSnapshot profCheck = await FirebaseFirestore.instance
            .collection("professor")
            .doc(_auth.currentUser!.uid)
            .get();
        if (profCheck.exists) {
          tipo = PerfilTipo.profesor;

          perfilAtual = PerfilProfessor.fromFirestore(
              profCheck.data() as Map<String, Object?>,
              FirebaseAuth.instance.currentUser!,
              update);
          await (perfilAtual as PerfilProfessor).getTurmas();
        }
      }
    }
    notifyListeners();
    return tipo;
  }

  update() {
    notifyListeners();
  }
}

enum PerfilTipo {
  profesor, //index 0
  aluno, //index 1
}
