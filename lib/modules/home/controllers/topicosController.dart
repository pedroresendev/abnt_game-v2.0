import 'package:abntplaybic/modules/home/models/model_tema.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TopicosController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> getTopicos() async {
    var qs = await _firestore.collection("topicos").get();
    List<Map<String, String>> listaTopicos = [];

    if (qs.docs.isEmpty) {
      return [];
    }

    for (var element in qs.docs) {
      listaTopicos.add({"titulo": element['titulo'], "id": element.id});
    }
    return listaTopicos;
  }

  Future<List<Map>> getSubTopicos(String topico) async {
    List<Map> listaSubTopicos = [];
    /*var qs = await _firestore.collection("topicos").get();
    String idSubTopico = "";

    if (qs.docs.isEmpty) {
      return [];
    }

    for (var element in qs.docs) {
      if (element['titulo'] == topico) {
        idSubTopico = element.id;
      }
    }*/

    var qs2 = await _firestore
        .collection("topicos")
        .doc(topico)
        .collection("subTopicos")
        .orderBy("indice")
        .get();

    if (qs2.docs.isEmpty) return [];

    for (var element1 in qs2.docs) {
      listaSubTopicos
          .add({...element1.data(), "id": element1.id, "idTopico": topico});
    }

    print(listaSubTopicos);
    return listaSubTopicos;
  }

  Future<List<Tema>> getAllAulasSubTopicos(
      String topico, String subTopico) async {
    List<Tema> listaTemas = [];
    /*var qs = await _firestore.collection("topicos").get();
    String idSubTopico = "";
    String idTema = "";

    if (qs.docs.isEmpty) {
      return [];
    }

    for (var element in qs.docs) {
      if (element['titulo'] == topico) {
        idSubTopico = element.id;
      }
    }

    var qs2 = await _firestore
        .collection("topicos")
        .doc(idSubTopico)
        .collection("subTopicos")
        .get();

    if (qs2.docs.isEmpty) return [];

    for (var element1 in qs2.docs) {
      if (element1['nomeTema'] == subTopico) {
        idTema = element1.id;
      }
    }

    var qs3 = await _firestore
        .collection("topicos")
        .doc(idSubTopico)
        .collection("subTopicos")
        .doc(idTema)
        .get();

    if (!qs3.exists) return [];
*/
    var qs3 = await FirebaseFirestore.instance
        .collection("topicos")
        .doc(topico)
        .collection("subTopicos")
        .doc(subTopico)
        .collection("aula")
        .orderBy("indice")
        .get();
    for (var value in qs3.docs) {
      listaTemas.add(Tema.fromMap(value.data()));
    }

    print(listaTemas);
    return listaTemas;
  }
}
