class CupomModel {
  final String id;
  final String nome;
  final String descricao;
  final int custoEmPontos;
  final String imagemUrl;

  CupomModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.custoEmPontos,
    required this.imagemUrl,
  });

  factory CupomModel.fromMap(Map<String, dynamic> map) {
    return CupomModel(
      id: map['id']?.toString() ?? map['Id']?.toString() ?? '',
      nome: map['nome']?.toString() ?? map['Nome']?.toString() ?? '',
      descricao: map['descricao']?.toString() ?? map['Descricao']?.toString() ?? '',
      custoEmPontos: (map['custoEmPontos'] ?? map['CustoEmPontos'] ?? 0) as int,
      imagemUrl: map['imagemUrl']?.toString() ?? map['ImagemUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'custoEmPontos': custoEmPontos,
      'imagemUrl': imagemUrl,
    };
  }
}
