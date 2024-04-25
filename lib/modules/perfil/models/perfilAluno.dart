import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilAluno extends Perfil {
  Function? _notify;
  int _melhorRanking = 0;
  int _rankingAtual = 0;
  int _xpAtual = 0;
  int _xpTotal = 0;
  String? _turmaID;
  String? _imageURL;
  //map deve ser usado assim: feitos[topicoPrincipal][subtopico][tarefa/aula]
  //o último map deve ser usado os valores tarefa ou aula referente a cada uma
  //das coisas e ambos retornam valor booleano, ou null se nao existir
  Map<String, Map<String, Map<String, bool>>>? _feitos = {};
  Turma? _turma;

  //construtor
  PerfilAluno(String id, String nome, String email,
      [String? fotoPerfil, this._notify])
      : super(id: id, nome: nome, email: email, fotoPerfil: fotoPerfil);

  @override
  getPerfil() async {
    var dadosUser = await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .get()
        .then((value) => value.data());
    if (dadosUser != null) {
      print(dadosUser["feitos"]);
      _melhorRanking = dadosUser["melhorRanking"] ?? 0;
      _rankingAtual = dadosUser["rankingAtual"] ?? 0;
      _xpAtual = dadosUser["xpAtual"] ?? 0;
      _xpTotal = dadosUser["xpColetado"] ?? 0;
      _turmaID = dadosUser["turma"];
      _feitos = Map.from(dadosUser["feitos"]);
      _imageURL = dadosUser["imageURL"] ?? "gs://abnt-play.appspot.com/users/img-default.jpg";
    }
  }

  PerfilAluno.novoAluno(User user)
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL);

  PerfilAluno.fromFirestore(Map<String, Object?> data, User user,
      [Function? notify])
      : super(
            nome: user.displayName!,
            email: user.email!,
            id: user.uid,
            fotoPerfil: user.photoURL) {
    _melhorRanking = data["melhorRanking"] as int? ?? 0;
    _rankingAtual = data["rankingAtual"] as int? ?? 0;
    _xpAtual = data["xpAtual"] as int? ?? 0;
    _xpTotal = data["xpColetado"] as int? ?? 0;
    _turmaID = data["turma"] as String?;
    _imageURL = data["imageURL"] as String?;
    _notify = notify;
  }

  @override
  toMap() {
    return {
      "nome": nome,
      "melhorRanking": _melhorRanking,
      "rankingAtual": _rankingAtual,
      "xpAtual": _xpAtual,
      "xpColetado": _xpTotal,
      "turma": _turmaID,
      "feitos": _feitos,
      "imageURL": _imageURL,
    };
  }

  @override
  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection("aluno")
        .doc(id)
        .update(toMap());
  }

  getTurma() async {
    if (_turmaID != null) {
      var data = await FirebaseFirestore.instance
          .collection("turma")
          .doc(_turmaID)
          .get();

      if (data.data() != null) {
        _turma = Turma.fromFirestoreDoc(data);
        var participantes = await FirebaseFirestore.instance
            .collection("aluno")
            .where("turma", isEqualTo: _turmaID)
            .get();

        _turma?.quantParticipantes = participantes.docs.length;

        var prof = await FirebaseFirestore.instance
            .collection("professor")
            .doc(_turma!.profID)
            .get();

        _turma!.profNome = prof["nome"];
      }
    }
  }

  void addXp(int xp) async {
    _xpAtual += xp;
    _xpTotal += xp;
    await updateFirestore();
  }

  updateImage(String imageURL) async{
    _imageURL = imageURL;
    await updateFirestore();
  }

  updateName(String nome) async{
    this.nome = nome;
    await updateFirestore();
  }

  listenData() {
    FirebaseFirestore.instance
        .collection("aluno")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      if (event.data()!["feitos"] != null) {
        _feitos = Map.from(event.data()!["feitos"]) //topico
            .map((key, value) => MapEntry(key, Map.from(value))) //subtopico
            .map((key, value) => MapEntry(key,
                value.map((key, value) => MapEntry(key, Map.from(value)))));
      } else {
        _feitos = {};
      }

      print(_feitos);
      _melhorRanking = event.data()!["melhorRanking"] ?? 0;
      _rankingAtual = event.data()!["rankingAtual"] ?? 0;
      _xpAtual = event.data()!["xpAtual"] ?? 0;
      _xpTotal = event.data()!["xpColetado"] ?? 0;
      _imageURL = event.data()!["imageURL"] ?? "";
      _notify != null ? _notify!() : null;
    });
  }

  marcaTarefa(String topico, String subTopico, [bool value = true]) {
    if (_feitos == null) {
      _feitos = {
        topico: {
          subTopico: {"tarefa": value}
        }
      };
    } else if (_feitos![topico] == null) {
      _feitos![topico] = {
        subTopico: {"tarefa": value}
      };
    } else if (_feitos![topico]![subTopico] == null) {
      _feitos![topico]![subTopico] = {"tarefa": value};
    } else {
      _feitos![topico]![subTopico]!["tarefa"] = value;
    }
    updateFirestore();
  }

  marcaAula(String topico, String subTopico, [bool value = true]) {
    if (_feitos == null) {
      _feitos = {
        topico: {
          subTopico: {"aula": value}
        }
      };
    } else if (_feitos![topico] == null) {
      _feitos![topico] = {
        subTopico: {"aula": value}
      };
    } else if (_feitos![topico]![subTopico] == null) {
      _feitos![topico]![subTopico] = {"aula": value};
    } else {
      _feitos![topico]![subTopico]!["aula"] = value;
    }
    updateFirestore();
  }

  bool checkTarefa(topico, subtopico) {
    return _feitos?[topico]?[subtopico]?["tarefa"] ?? false;
  }

  void updateRanking(int newRanking) async {
    _rankingAtual = newRanking;
    if (newRanking < _melhorRanking) {
      _melhorRanking = newRanking;
    }
    await updateFirestore();
    (_notify != null) ? _notify!() : null;
  }

  set setTurma(String novaTurma) {
    _turmaID = novaTurma;

    (_notify != null) ? _notify!() : null;
  }

  //Getters
  int get xpAtual => _xpAtual;
  int get xpTotal => _xpTotal;
  int get melhorRanking => _melhorRanking;
  int get rankingAtual => _rankingAtual;
  Map<String, Map<String, Map<String, bool>>>? get feitos => _feitos;
  String? get turmaID => _turmaID;
  String? get imageURL => _imageURL;
  Turma? get turma => _turma;
}
