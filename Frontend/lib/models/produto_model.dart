import 'dart:developer';

class ProdutoModel {
  final String id;
  final String nome;
  final String descricao;
  final int custoEmPontos;
  final int quantidadeDisponivel;
  final String imagemUrl;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.custoEmPontos,
    required this.quantidadeDisponivel,
    required this.imagemUrl,
  });

  /// Cria um ProdutoModel a partir de um [Map], tratando diferentes formatos de chave.
  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    final String id = map['id'] ?? map['Id'] ?? '';

    if (id.isEmpty) {
      log('⚠️ Produto recebido sem ID válido: $map');
    }

    return ProdutoModel(
      id: id,
      nome: map['nome'] ?? map['Nome'] ?? '',
      descricao: map['descricao'] ?? map['Descricao'] ?? '',
      custoEmPontos: map['custoEmPontos'] ?? map['CustoEmPontos'] ?? 0,
      quantidadeDisponivel: map['quantidadeDisponivel'] ?? map['QuantidadeDisponivel'] ?? 0,
      imagemUrl: map['imagemUrl'] ?? map['ImagemUrl'] ?? '',
    );
  }

  /// Converte o modelo para um JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'custoEmPontos': custoEmPontos,
      'quantidadeDisponivel': quantidadeDisponivel,
      'imagemUrl': imagemUrl,
    };
  }

  /// Cria uma cópia modificada do objeto.
  ProdutoModel copyWith({
    String? id,
    String? nome,
    String? descricao,
    int? custoEmPontos,
    int? quantidadeDisponivel,
    String? imagemUrl,
  }) {
    return ProdutoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      custoEmPontos: custoEmPontos ?? this.custoEmPontos,
      quantidadeDisponivel: quantidadeDisponivel ?? this.quantidadeDisponivel,
      imagemUrl: imagemUrl ?? this.imagemUrl,
    );
  }
}
