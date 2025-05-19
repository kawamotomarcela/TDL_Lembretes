class Usuario {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final int pontos;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.pontos,
  });

  Usuario copyWith({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    int? pontos,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      pontos: pontos ?? this.pontos,
    );
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      pontos: map['pontos'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'pontos': pontos,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      pontos: json['pontos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'pontos': pontos,
    };
  }
}
