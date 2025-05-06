// lib/models/usuario_model.dart

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

  // Método para criar um objeto Usuario a partir de um Map (SQLite)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      pontos: map['pontos'],
    );
  }

  // Método para converter o Usuario em um Map (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'pontos': pontos,
    };
  }
}
