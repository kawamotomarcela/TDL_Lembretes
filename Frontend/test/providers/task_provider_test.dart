import 'package:flutter_test/flutter_test.dart';
import 'package:grupotdl/providers/task_provider.dart';
import 'package:grupotdl/models/task_model.dart';

void main() {
  group('TaskProvider', () {
    test('Adiciona uma nova tarefa', () {
      final provider = TaskProvider();
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

      // Verifica se a tarefa foi adicionada corretamente
      expect(provider.tarefas.length, 1);
      expect(provider.tarefas.first.titulo, 'Nova Tarefa');
      expect(provider.tarefas.first.status, StatusTarefa.pendente);
    });

    test('Conclui a tarefa', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '2',
        titulo: 'Concluir tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id);

      // Verifica se a tarefa teve seu status alterado para "andamento"
      expect(provider.tarefas.first.status, StatusTarefa.andamento);
    });

    test('Alterna o status de andamento para concluída', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '3',
        titulo: 'Concluir tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id); // Primeiro para "andamento"
      provider.concluir(tarefa.id); // Segundo para "concluída"

      // Verifica se o status da tarefa foi alterado para "concluída"
      expect(provider.tarefas.first.status, StatusTarefa.concluida);
    });

    test('Alterna o status de concluída para pendente', () {
      final provider = TaskProvider();
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
      provider.concluir(tarefa.id); // Primeiro para "pendente"

      // Verifica se o status da tarefa foi alterado para "pendente"
      expect(provider.tarefas.first.status, StatusTarefa.pendente);
    });

    test('Remove uma tarefa', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '5',
        titulo: 'Tarefa a ser removida',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 2,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);
      provider.remover(tarefa.id);

      // Verifica se a tarefa foi removida corretamente
      expect(provider.tarefas.isEmpty, true);
    });

    test('Editar uma tarefa', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '6',
        titulo: 'Editar tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 2,
        status: StatusTarefa.pendente,
        alarmeAtivado: false,
      );

      provider.adicionar(tarefa);

      // Atualizar a tarefa
      final tarefaAtualizada = tarefa.copyWith(titulo: 'Tarefa atualizada', categoria: 'Atualizações');
      provider.editar(tarefaAtualizada);

      // Verifica se a tarefa foi atualizada corretamente
      expect(provider.tarefas.first.titulo, 'Tarefa atualizada');
      expect(provider.tarefas.first.categoria, 'Atualizações');
    });
  });
}
