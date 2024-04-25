// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Conquista {
  final String? titulo;
  final String? progresso1;
  final String? progresso2;
  final String? progresso3;
  final int progressoAluno;
  Conquista({
    required this.titulo,
    required this.progresso1,
    required this.progresso2,
    required this.progresso3,
    required this.progressoAluno,
  });
  

  Conquista copyWith({
    String? titulo,
    String? progresso1,
    String? progresso2,
    String? progresso3,
    int? progressoAluno,
  }) {
    return Conquista(
      titulo: titulo ?? this.titulo,
      progresso1: progresso1 ?? this.progresso1,
      progresso2: progresso2 ?? this.progresso2,
      progresso3: progresso3 ?? this.progresso3,
      progressoAluno: progressoAluno ?? this.progressoAluno,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'progresso1': progresso1,
      'progresso2': progresso2,
      'progresso3': progresso3,
      'progressoAluno': progressoAluno,
    };
  }

  factory Conquista.fromMap(Map<String, dynamic> map) {
    return Conquista(
      titulo: map['titulo'] as String,
      progresso1: map['progresso1'] as String,
      progresso2: map['progresso2'] as String,
      progresso3: map['progresso3'] as String,
      progressoAluno: map['progressoAluno'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conquista.fromJson(String source) => Conquista.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conquista(titulo: $titulo, progresso1: $progresso1, progresso2: $progresso2, progresso3: $progresso3, progressoAluno: $progressoAluno)';
  }

  @override
  bool operator ==(covariant Conquista other) {
    if (identical(this, other)) return true;
  
    return 
      other.titulo == titulo &&
      other.progresso1 == progresso1 &&
      other.progresso2 == progresso2 &&
      other.progresso3 == progresso3 &&
      other.progressoAluno == progressoAluno;
  }

  @override
  int get hashCode {
    return titulo.hashCode ^
      progresso1.hashCode ^
      progresso2.hashCode ^
      progresso3.hashCode ^
      progressoAluno.hashCode;
  }
}
