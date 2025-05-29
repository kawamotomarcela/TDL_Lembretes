class CupomModel {
  final String titulo;
  final String descricao;
  final String codigo;

  CupomModel({
    required this.titulo,
    required this.descricao,
    required this.codigo,
  });

  factory CupomModel.fromMap(Map<String, dynamic> map) {
    return CupomModel(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      codigo: map['codigo'] ?? '',
    );
  }
}
