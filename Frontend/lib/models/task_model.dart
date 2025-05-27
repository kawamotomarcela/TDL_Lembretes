enum StatusTarefa { emAndamento, concluida, expirada }
enum PrioridadeTarefa { baixa, media, alta }

class TaskModel {
  final String id;
  final String titulo;
  final String descricao;
  final DateTime dataCriacao;
  final DateTime dataFinalizacao;
  final StatusTarefa status;
  final PrioridadeTarefa prioridade;
  final bool alarmeAtivado;

  TaskModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.dataFinalizacao,
    this.status = StatusTarefa.emAndamento,
    this.prioridade = PrioridadeTarefa.baixa,
    this.alarmeAtivado = false,
  });

  TaskModel copyWith({
    String? id,
    String? titulo,
    String? descricao,
    DateTime? dataCriacao,
    DateTime? dataFinalizacao,
    StatusTarefa? status,
    PrioridadeTarefa? prioridade,
    bool? alarmeAtivado,
  }) {
    return TaskModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataFinalizacao: dataFinalizacao ?? this.dataFinalizacao,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      alarmeAtivado: alarmeAtivado ?? this.alarmeAtivado,
    );
  }

  StatusTarefa proximoStatus() {
    switch (status) {
      case StatusTarefa.emAndamento:
        return StatusTarefa.concluida;
      case StatusTarefa.concluida:
      case StatusTarefa.expirada:
        return StatusTarefa.emAndamento;
    }
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? map['Id'],
      titulo: map['titulo'] ?? map['Titulo'],
      descricao: map['descricao'] ?? map['Descricao'] ?? '',
      dataCriacao: DateTime.parse(map['dataCriacao'] ?? map['DataCriacao']),
      dataFinalizacao: DateTime.parse(map['dataFinalizacao'] ?? map['DataFinalizacao']),
      status: StatusTarefa.values.firstWhere(
        (e) => e.name.toLowerCase() == (map['status'] ?? map['Status']).toString().toLowerCase(),
        orElse: () => StatusTarefa.emAndamento,
      ),
      prioridade: PrioridadeTarefa.values.firstWhere(
        (e) => e.name.toLowerCase() == (map['prioridade'] ?? map['Prioridade']).toString().toLowerCase(),
        orElse: () => PrioridadeTarefa.baixa,
      ),
      alarmeAtivado: (map['alarmeAtivado'] ?? map['AlarmeAtivado']) == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataFinalizacao': dataFinalizacao.toIso8601String(),
      'status': status.name,
      'prioridade': prioridade.name,
      'alarmeAtivado': alarmeAtivado,
    };
  }

  Map<String, dynamic> toMapForDto() {
    String capitalize(String value) =>
        value[0].toUpperCase() + value.substring(1).toLowerCase();

    return {
      'Id': id,
      'Titulo': titulo,
      'Descricao': descricao,
      'DataCriacao': dataCriacao.toIso8601String(),
      'DataFinalizacao': dataFinalizacao.toUtc().toIso8601String(),
      'Status': capitalize(status.name),
      'Prioridade': capitalize(prioridade.name),
      'AlarmeAtivado': alarmeAtivado,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  @override
  String toString() {
    return 'TaskModel(id: $id, titulo: $titulo, status: $status, prioridade: $prioridade, alarme: $alarmeAtivado)';
  }
}
