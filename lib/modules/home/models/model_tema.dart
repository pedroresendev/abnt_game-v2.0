// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tema {
  String titulo;
  dynamic conteudo;
  String descricao;
  Tema({
    required this.titulo,
    required this.conteudo,
    required this.descricao,
  });

  Tema copyWith({
    String? titulo,
    dynamic? conteudo,
    String? descricao,
  }) {
    return Tema(
      titulo: titulo ?? this.titulo,
      conteudo: conteudo ?? this.conteudo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'conteudo': conteudo,
      'descricao': descricao,
    };
  }

  factory Tema.fromMap(Map<String, dynamic>? map) {
    return Tema(
      titulo: map?['titulo'] as String,
      conteudo: map?['conteudo'] as dynamic,
      descricao: map?['descricao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tema.fromJson(String source) => Tema.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tema(titulo: $titulo, conteudo: $conteudo, descricao: $descricao)';

  @override
  bool operator ==(covariant Tema other) {
    if (identical(this, other)) return true;
  
    return 
      other.titulo == titulo &&
      other.conteudo == conteudo &&
      other.descricao == descricao;
  }

  @override
  int get hashCode => titulo.hashCode ^ conteudo.hashCode ^ descricao.hashCode;
}
