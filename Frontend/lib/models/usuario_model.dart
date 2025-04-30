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
