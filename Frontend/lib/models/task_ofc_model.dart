import 'package:grupotdl/models/task_model.dart';

class TaskOfcModel {
  final String titulo;
  final String descricao;
  final PrioridadeTarefa prioridade;
  final DateTime dataCriacao;
  final DateTime dataFinalizacao;
  final int pontos;

  TaskOfcModel({
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.dataCriacao,
    required this.dataFinalizacao,
    required this.pontos,
  });

  factory TaskOfcModel.fromMap(Map<String, dynamic> map) {
    return TaskOfcModel(
      titulo: map['titulo'] ?? map['Titulo'],
      descricao: map['descricao'] ?? map['Descricao'],
      prioridade: PrioridadeTarefa.values.firstWhere(
        (e) => e.name.toLowerCase() == (map['prioridade'] ?? map['Prioridade']).toString().toLowerCase(),
        orElse: () => PrioridadeTarefa.baixa,
      ),
      dataCriacao: DateTime.parse(map['dataCriacao'] ?? map['DataCriacao']),
      dataFinalizacao: DateTime.parse(map['dataFinalizacao'] ?? map['DataFinalizacao']),
      pontos: map['pontos'] ?? map['Pontos'] ?? 0,
    );
  }
}
