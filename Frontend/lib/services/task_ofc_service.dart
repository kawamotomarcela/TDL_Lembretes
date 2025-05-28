import '../api/api_client.dart';
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

  Future<bool> deleteOfficialTask(String id) async {
    try {
      await api.delete('/TarefaOficial/$id');
      return true;
    } catch (_) {
      return false;
    }
  }
}
