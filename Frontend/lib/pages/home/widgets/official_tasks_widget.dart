import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/models/task_ofc_model.dart';
import 'package:grupotdl/providers/task_ofc_provider.dart';
import 'package:grupotdl/providers/usuario_provider.dart';

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
      if (mounted) {
        Provider.of<TaskOfcProvider>(context, listen: false).carregarTarefas();
      }
    });
  }

  Future<void> _mostrarComprovacaoDialog({
    required TaskOfcModel tarefa,
    required String usuarioId,
    required void Function(String url) onConfirmar,
  }) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Descrição',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Text(tarefa.descricao, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            const Text(
              'URL da imagem de comprovação',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'https://exemplo.com/imagem.png',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final url = controller.text.trim();
              if (url.isNotEmpty) {
                Navigator.pop(context);
                onConfirmar(url);
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskOfcProvider>();
    final usuarioProvider = context.read<UsuarioProvider>();
    final tarefas = provider.tarefas;
    final loading = provider.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📌 Tarefas Oficiais',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarefa.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 18, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text(
                            'Pontos: ${tarefa.pontos}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Venc: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${tarefa.dataFinalizacao.day.toString().padLeft(2, '0')}/'
                            '${tarefa.dataFinalizacao.month.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final userId = usuarioProvider.usuario?.id ?? '';
                            if (userId.isEmpty) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Erro: usuário não identificado'),
                                ),
                              );
                              return;
                            }

                            _mostrarComprovacaoDialog(
                              tarefa: tarefa,
                              usuarioId: userId,
                              onConfirmar: (url) async {
                                final sucesso = await provider.enviarComprovacao(
                                  usuarioId: userId,
                                  tarefaId: tarefa.id,
                                  comprovacaoUrl: url,
                                );

                                if (!mounted) return;

                                if (sucesso) {
                                  final concluiu = await provider.concluirTarefa(tarefa.id);

                                  if (!mounted) return;

                                  if (concluiu) {
                                    usuarioProvider.adicionarPontos(tarefa.pontos);

                                    if (!mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '🎉 Você ganhou ${tarefa.pontos} pontos!',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Saiba mais',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
