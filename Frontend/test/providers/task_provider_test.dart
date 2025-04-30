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
      );

      provider.adicionar(tarefa);

      expect(provider.tarefas.length, 1);
      expect(provider.tarefas.first.titulo, 'Nova Tarefa');
    });

    test('Alterna status da tarefa (pendente > andamento)', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '2',
        titulo: 'Alterar Status',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id);

      expect(provider.tarefas.first.status, StatusTarefa.andamento);
    });

    test('Alterna status da tarefa (andamento > concluida)', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '3',
        titulo: 'Concluir tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id); // -> andamento
      provider.concluir(tarefa.id); // -> concluída

      expect(provider.tarefas.first.status, StatusTarefa.concluida);
    });

    test('Alterna status da tarefa (concluida > pendente)', () {
      final provider = TaskProvider();
      final tarefa = TaskModel(
        id: '4',
        titulo: 'Reiniciar tarefa',
        data: DateTime.now(),
        categoria: 'Testes',
        prioridade: 1,
        status: StatusTarefa.concluida,
      );

      provider.adicionar(tarefa);
      provider.concluir(tarefa.id); // -> pendente

      expect(provider.tarefas.first.status, StatusTarefa.pendente);
    });
  });
}

