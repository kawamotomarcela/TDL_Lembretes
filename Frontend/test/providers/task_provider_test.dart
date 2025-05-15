import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:grupotdl/providers/task_provider.dart';
import 'package:grupotdl/models/task_model.dart';
import 'package:grupotdl/services/task_service.dart';

@GenerateMocks([TaskService])
import 'task_provider_test.mocks.dart';

void main() {
  group('TaskProvider', () {
    late TaskProvider provider;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      provider = TaskProvider(taskService: mockTaskService);
    });

    test('Adiciona uma nova tarefa', () {
      final tarefa = TaskModel(
        id: '1',
        titulo: 'Nova Tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 2,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);

      expect(provider.tarefas.length, 1);
      expect(provider.tarefas.first.titulo, 'Nova Tarefa');
    });

    test('Conclui tarefa (pendente → andamento)', () {
      final tarefa = TaskModel(
        id: '2',
        titulo: 'Avançar tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id);

      expect(provider.tarefas.first.status, StatusTarefa.andamento);
    });

    test('Conclui tarefa (andamento → concluída)', () {
      final tarefa = TaskModel(
        id: '3',
        titulo: 'Finalizar tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.andamento,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id);

      expect(provider.tarefas.first.status, StatusTarefa.concluida);
    });

    test('Conclui tarefa (concluída → pendente)', () {
      final tarefa = TaskModel(
        id: '4',
        titulo: 'Reiniciar tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.concluida,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id);

      expect(provider.tarefas.first.status, StatusTarefa.pendente);
    });

    test('Remove tarefa', () {
      final tarefa = TaskModel(
        id: '5',
        titulo: 'Remover tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 2,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.remover(tarefa.id);

      expect(provider.tarefas.isEmpty, true);
    });

    test('Edita tarefa existente', () {
      final tarefa = TaskModel(
        id: '6',
        titulo: 'Tarefa original',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 2,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);

      final atualizada = tarefa.copyWith(
        titulo: 'Tarefa atualizada',
        categoria: 'Atualizações',
      );

      provider.editar(atualizada);

      expect(provider.tarefas.first.titulo, 'Tarefa atualizada');
      expect(provider.tarefas.first.categoria, 'Atualizações');
    });
  });
}
