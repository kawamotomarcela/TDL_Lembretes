import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/task_ofc_provider.dart';
import '../../../providers/usuario_provider.dart';

class OfficialTasksWidget extends StatefulWidget {
  const OfficialTasksWidget({super.key});

  @override
  State<OfficialTasksWidget> createState() => _OfficialTasksWidgetState();
}

class _OfficialTasksWidgetState extends State<OfficialTasksWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskOfcProvider>(context, listen: false).carregarTarefas();
    });
  }

  void _concluirTarefa(BuildContext context, int index) {
    final provider = Provider.of<TaskOfcProvider>(context, listen: false);
    final usuarioProvider = Provider.of<UsuarioProvider>(
      context,
      listen: false,
    );
    final tarefa = provider.tarefas[index];

    usuarioProvider.adicionarPontos(tarefa.pontos);

    provider.removerTarefa(tarefa);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🎉 Você ganhou ${tarefa.pontos} pontos!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskOfcProvider>(context);
    final tarefas = provider.tarefas;
    final loading = provider.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📌 Tarefas Oficiais',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (loading)
          const Center(child: CircularProgressIndicator())
        else if (tarefas.isEmpty)
          const Text('Nenhuma tarefa oficial disponível no momento.')
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tarefas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarefa.titulo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(tarefa.descricao),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Vence: ${tarefa.dataFinalizacao.day}/${tarefa.dataFinalizacao.month} às '
                            '${tarefa.dataFinalizacao.hour.toString().padLeft(2, '0')}:${tarefa.dataFinalizacao.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pontos: ${tarefa.pontos}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _concluirTarefa(context, index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Concluir'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
