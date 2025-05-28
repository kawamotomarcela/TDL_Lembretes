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

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? map['Nome'] ?? '',
      descricao: map['descricao'] ?? map['Descricao'] ?? '',
      custoEmPontos: map['custoEmPontos'] ?? map['CustoEmPontos'] ?? 0,
      quantidadeDisponivel: map['quantidadeDisponivel'] ?? map['QuantidadeDisponivel'] ?? 0,
      imagemUrl: map['imagemUrl'] ?? map['ImagemUrl'] ?? '',
    );
  }

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


