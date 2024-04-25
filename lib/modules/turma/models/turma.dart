import 'package:cloud_firestore/cloud_firestore.dart';

class Turma {
  String _id;
  String _nome;
  Map<String, List> _topicosAtivos;
  String _profID;
  String? profNome;
  int quantParticipantes;

  Turma(this._id, this._nome, this._topicosAtivos, this._profID,
      [this.quantParticipantes = 0]);

  String get id => _id;
  String get nome => _nome;
  Map<String, List> get topicosAtivos => _topicosAtivos;
  String get profID => _profID;

  set mudarTopicos(Map<String, List> novosTopicos) {
    _topicosAtivos = novosTopicos;
  }

  set mudarNome(String novoNome) {
    _nome = novoNome;
  }

  Turma.fromFirestore(QueryDocumentSnapshot<Map> doc)
      : this(
            doc.id,
            doc.data()["nome"],
            Map<String, List>.from(doc.data()["topicosAtivos"]),
            doc.data()["profID"]);

  Turma.fromFirestoreDoc(DocumentSnapshot<Map> doc)
      : this(
            doc.id,
            doc.data()!["nome"],
            Map<String, List>.from(doc.data()!["topicosAtivos"]),
            doc.data()!["profID"]);

  Map<String, Object?> toFirestore() {
    return {"nome": _nome, "topicosAtivos": _topicosAtivos, "profID": _profID};
  }
}
