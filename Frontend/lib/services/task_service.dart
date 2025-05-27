import 'dart:convert';
import 'dart:developer';
import 'package:grupotdl/models/task_model.dart';
import 'package:grupotdl/api/api_client.dart';

class TaskService {
  final ApiClient api;

  TaskService(this.api);

  /// 🔍 Busca as tarefas vinculadas ao usuário autenticado
  Future<List<TaskModel>> fetchTasks() async {
    try {
      final response = await api.get('/TarefaPersonalizada');

      if (response is List) {
        return response.map((json) => TaskModel.fromMap(json)).toList();
      }

      log('⚠️ Resposta inesperada ao buscar tarefas: $response');
      return [];
    } catch (e, stack) {
      log('❌ Erro ao buscar tarefas', error: e, stackTrace: stack);
      return [];
    }
  }

  /// 📝 Cria uma nova tarefa para o usuário autenticado
  Future<TaskModel?> createTask(TaskModel task) async {
    try {
      String formatEnum(String value) =>
          value[0].toUpperCase() + value.substring(1);

      final payload = {
        'Titulo': task.titulo,
        'Descricao': task.descricao,
        'DataFinalizacao': task.dataFinalizacao.toIso8601String(),
        'Prioridade': formatEnum(task.prioridade.name),
      };

      log('📤 POST /TarefaPersonalizada - Payload: ${jsonEncode(payload)}');

      final response = await api.post('/TarefaPersonalizada', payload);

      log('✅ Resposta da criação de tarefa: $response');

      if (response is Map<String, dynamic>) {
        if (response.containsKey('id')) {
          return TaskModel.fromMap(response);
        }

        log('⚠️ Resposta parcial ao criar tarefa, mapeando manualmente');
        return TaskModel(
          id: response['Id'] ?? '',
          titulo: task.titulo,
          descricao: task.descricao,
          dataCriacao: DateTime.now(),
          dataFinalizacao: task.dataFinalizacao,
          status: StatusTarefa.emAndamento,
          prioridade: task.prioridade,
          alarmeAtivado: task.alarmeAtivado,
        );
      }

      log('❗ Resposta inesperada ao criar tarefa: $response');
      return null;
    } catch (e, stack) {
      log('❌ Erro ao criar tarefa', error: e, stackTrace: stack);
      return null;
    }
  }

  /// ✏️ Atualiza uma tarefa existente
  Future<bool> updateTask(TaskModel task) async {
    try {
      final payload = task.toMapForDto();

      log('🛠 PUT /TarefaPersonalizada/${task.id} - Payload: ${jsonEncode(payload)}');

      await api.put('/TarefaPersonalizada/${task.id}', payload);
      return true;
    } catch (e, stack) {
      log('❌ Erro ao atualizar tarefa', error: e, stackTrace: stack);
      return false;
    }
  }

  /// ❌ Remove uma tarefa específica
  Future<bool> deleteTask(String id) async {
    try {
      log('🗑 DELETE /TarefaPersonalizada/$id');
      await api.delete('/TarefaPersonalizada/$id');
      return true;
    } catch (e, stack) {
      log('❌ Erro ao excluir tarefa', error: e, stackTrace: stack);
      return false;
    }
  }

  /// 🔁 Atualiza o status da tarefa
  Future<bool> toggleStatus(String id, StatusTarefa novoStatus) async {
    try {
      final statusStr = novoStatus.name[0].toUpperCase() + novoStatus.name.substring(1);
      final payload = { 'Status': statusStr };

      log('🔄 PUT /TarefaPersonalizada/$id/status - Payload: ${jsonEncode(payload)}');

      await api.put('/TarefaPersonalizada/$id/status', payload);
      return true;
    } catch (e, stack) {
      log('❌ Erro ao alterar status da tarefa', error: e, stackTrace: stack);
      return false;
    }
  }
}

