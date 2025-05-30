import 'package:grupotdl/models/task_model.dart';

class TaskOfcModel {
  final String id;
  final String titulo;
  final String descricao;
  final PrioridadeTarefa prioridade;
  final DateTime dataCriacao;
  final DateTime dataFinalizacao;
  final int pontos;
  final String? comprovacaoUrl;

  TaskOfcModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.dataCriacao,
    required this.dataFinalizacao,
    required this.pontos,
    this.comprovacaoUrl,
  });

  factory TaskOfcModel.fromMap(Map<String, dynamic> map) {
    return TaskOfcModel(
      id: map['id'] ?? map['Id'] ?? '',
      titulo: map['titulo'] ?? map['Titulo'] ?? '',
      descricao: map['descricao'] ?? map['Descricao'] ?? '',
      prioridade: PrioridadeTarefa.values.firstWhere(
        (e) => e.name.toLowerCase() ==
            (map['prioridade'] ?? map['Prioridade']).toString().toLowerCase(),
        orElse: () => PrioridadeTarefa.baixa,
      ),
      dataCriacao: DateTime.parse(map['dataCriacao'] ?? map['DataCriacao']),
      dataFinalizacao:
          DateTime.parse(map['dataFinalizacao'] ?? map['DataFinalizacao']),
      pontos: map['pontos'] ?? map['Pontos'] ?? 0,
      comprovacaoUrl: map['comprovacaoUrl'] ?? map['ComprovacaoUrl'],
    );
  }

  TaskOfcModel copyWith({
    String? id,
    String? titulo,
    String? descricao,
    PrioridadeTarefa? prioridade,
    DateTime? dataCriacao,
    DateTime? dataFinalizacao,
    int? pontos,
    String? comprovacaoUrl,
  }) {
    return TaskOfcModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      prioridade: prioridade ?? this.prioridade,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataFinalizacao: dataFinalizacao ?? this.dataFinalizacao,
      pontos: pontos ?? this.pontos,
      comprovacaoUrl: comprovacaoUrl ?? this.comprovacaoUrl,
    );
  }
}

