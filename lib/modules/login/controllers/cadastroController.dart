import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroController {
  TextEditingController email = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();
  criarConta() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: senha.text);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(nome.text);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
