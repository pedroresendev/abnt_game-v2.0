import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  TextEditingController email = TextEditingController();

  TextEditingController senha = TextEditingController();
  login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: senha.text);
    } catch (e) {
      rethrow;
    }
  }

  Future<PerfilTipo?> checkUser(String id) async {
    bool existeAluno = await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .get()
        .then((value) {
      return value.exists;
    });

    if (!existeAluno) {
      bool existeProf = await FirebaseFirestore.instance
          .collection("professor")
          .doc(id)
          .get()
          .then((value) {
        return value.exists;
      });
      if (existeProf) {
        return PerfilTipo.profesor;
      } else {
        return null;
      }
    } else {
      return PerfilTipo.aluno;
    }
  }
}
