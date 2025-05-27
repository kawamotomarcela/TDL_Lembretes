import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:grupotdl/providers/task_provider.dart';
import 'package:grupotdl/models/task_model.dart';
import 'package:grupotdl/services/task_service.dart';

import 'task_provider_test.mocks.dart';

@GenerateMocks([TaskService])
void main() {
  group('TaskProvider', () {
    late TaskProvider provider;
    late MockTaskService mockTaskService;

    final fakeTask = TaskModel(
      id: '1',
      titulo: 'Nova Tarefa',
      descricao: 'Testes',
      dataCriacao: DateTime.now(),
      dataFinalizacao: DateTime.now().add(const Duration(days: 2)),
      prioridade: PrioridadeTarefa.media,
      status: StatusTarefa.emAndamento,
      alarmeAtivado: false,
    );

    setUp(() {
      mockTaskService = MockTaskService();
      provider = TaskProvider(taskService: mockTaskService);
    });

    test('Adiciona uma nova tarefa', () async {
      when(mockTaskService.createTask(any)).thenAnswer((_) async => fakeTask);

      await provider.adicionar(fakeTask);

      expect(provider.tarefas.length, 1);
      expect(provider.tarefas.first.titulo, 'Nova Tarefa');
    });


    test('Remove tarefa', () async {
      when(mockTaskService.deleteTask(any)).thenAnswer((_) async => true);
      provider.tarefas.add(fakeTask);

      await provider.remover(fakeTask.id);

      expect(provider.tarefas.isEmpty, true);
    });

    test('Edita tarefa existente', () async {
      final updatedTask = fakeTask.copyWith(
        titulo: 'Tarefa Editada',
        descricao: 'Categoria X',
      );

      when(mockTaskService.updateTask(any)).thenAnswer((_) async => true);
      provider.tarefas.add(fakeTask);

      await provider.editar(updatedTask);

      expect(provider.tarefas.first.titulo, 'Tarefa Editada');
      expect(provider.tarefas.first.descricao, 'Categoria X');
    });
  });
}
