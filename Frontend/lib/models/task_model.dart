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
  final bool alarmeAtivado;

  TaskModel({
    required this.id,
    required this.titulo,
    required this.data,
    required this.categoria,
    required this.prioridade,
    this.status = StatusTarefa.pendente,
    this.alarmeAtivado = false,
  });

  TaskModel copyWith({
    String? id,
    String? titulo,
    DateTime? data,
    String? categoria,
    int? prioridade,
    StatusTarefa? status,
    bool? alarmeAtivado,
  }) {
    return TaskModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      data: data ?? this.data,
      categoria: categoria ?? this.categoria,
      prioridade: prioridade ?? this.prioridade,
      status: status ?? this.status,
      alarmeAtivado: alarmeAtivado ?? this.alarmeAtivado,
    );
  }

  StatusTarefa proximoStatus() {
    switch (status) {
      case StatusTarefa.pendente:
        return StatusTarefa.andamento;
      case StatusTarefa.andamento:
        return StatusTarefa.concluida;
      case StatusTarefa.concluida:
        return StatusTarefa.pendente;
    }
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      titulo: map['titulo'],
      data: DateTime.parse(map['data']),
      categoria: map['categoria'],
      prioridade: map['prioridade'],
      status: StatusTarefa.values[map['status']],
      alarmeAtivado: map['alarmeAtivado'] == 1 || map['alarmeAtivado'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'data': data.toIso8601String(),
      'categoria': categoria,
      'prioridade': prioridade,
      'status': status.index,
      'alarmeAtivado': alarmeAtivado ? 1 : 0,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      titulo: json['titulo'],
      data: DateTime.parse(json['data']),
      categoria: json['categoria'],
      prioridade: json['prioridade'],
      status: StatusTarefa.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => StatusTarefa.pendente,
      ),
      alarmeAtivado: json['alarmeAtivado'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'data': data.toIso8601String(),
      'categoria': categoria,
      'prioridade': prioridade,
      'status': status.toString().split('.').last,
      'alarmeAtivado': alarmeAtivado,
    };
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, titulo: $titulo, status: $status, alarme: $alarmeAtivado)';
  }
}


