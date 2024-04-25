import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TipoPerfilController {
  setProfessor() async {
    FirebaseFirestore.instance
        .collection("professor")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "nome": FirebaseAuth.instance.currentUser!.displayName,
    });
  }
}
