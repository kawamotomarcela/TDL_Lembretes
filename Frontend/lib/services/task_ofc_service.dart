import 'package:grupotdl/api/api_client.dart';
import 'package:grupotdl/models/task_ofc_model.dart';

class TaskOfcService {
  final ApiClient api;

  TaskOfcService(this.api);

  Future<List<TaskOfcModel>> fetchOfficialTasks() async {
    final response = await api.get('/TarefaOficial');

    if (response is List) {
      return response.map((json) => TaskOfcModel.fromMap(json)).toList();
    }

    return [];
  }

  Future<void> enviarComprovacao({
    required String usuarioId,
    required String tarefaId,
    required String comprovacaoUrl,
  }) async {
    final response = await api.put(
      '/UsuarioTarefasOficial/$usuarioId/tarefas-oficiais/$tarefaId/comprovacao',
      {
        'comprovacaoUrl': comprovacaoUrl,
      },
    );

    if (response == null || response['statusCode'] == 400) {
      throw Exception('Erro ao enviar imagem de comprovação');
    }
  }

  Future<void> concluirTarefa(String tarefaId) async {
    final response = await api.put('/TarefaOficial/concluir/$tarefaId', {});

    if (response == null || response['statusCode'] == 400) {
      throw Exception('Erro ao concluir tarefa oficial');
    }
  }

  Future<bool> deleteOfficialTask(String id) async {
    try {
      await api.delete('/TarefaOficial/$id');
      return true;
    } catch (_) {
      return false;
    }
  }
}
