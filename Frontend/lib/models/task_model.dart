enum StatusTarefa {
  pendente,
  andamento,
  concluida,
}

class TaskModel {
  final String id;
  final String titulo;
  final DateTime data;
  final String categoria;
  final int prioridade;
  final StatusTarefa status;

  TaskModel({
    required this.id,
    required this.titulo,
    required this.data,
    required this.categoria,
    required this.prioridade,
    this.status = StatusTarefa.pendente,
  });

  TaskModel copyWith({
    String? id,
    String? titulo,
    DateTime? data,
    String? categoria,
    int? prioridade,
    StatusTarefa? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      data: data ?? this.data,
      categoria: categoria ?? this.categoria,
      prioridade: prioridade ?? this.prioridade,
      status: status ?? this.status,
    );
  }
}

