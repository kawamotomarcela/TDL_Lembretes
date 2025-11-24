import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:grupotdl/models/task_ofc_model.dart';
import 'package:grupotdl/providers/task_ofc_provider.dart';
import 'package:grupotdl/providers/usuario_provider.dart';

class OfficialTasksWidget extends StatefulWidget {
  const OfficialTasksWidget({super.key});

  @override
  State<OfficialTasksWidget> createState() => _OfficialTasksWidgetState();
}

class _OfficialTasksWidgetState extends State<OfficialTasksWidget> {
  static const Color primaryBlue = Color.fromARGB(255, 51, 126, 202);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TaskOfcProvider>().carregarTarefas();
      }
    });
  }

  Future<void> _mostrarComprovacaoDialog({
    required TaskOfcModel tarefa,
    required String usuarioId,
    required void Function(String url) onConfirmar,
  }) async {
    final controller = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryBlue.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: primaryBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Enviar comprovação',
                    style: TextStyle(
                      color: primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tarefa.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tarefa.descricao,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'URL da imagem de comprovação',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'https://exemplo.com/imagem.png',
                      prefixIcon: const Icon(Icons.link_rounded, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Envie uma imagem que comprove a realização da tarefa.',
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(foregroundColor: primaryBlue),
                child: const Text('Cancelar'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.upload_rounded, size: 18),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  final url = controller.text.trim();
                  if (url.isNotEmpty) {
                    Navigator.pop(context);
                    onConfirmar(url);
                  }
                },
                label: const Text('Enviar'),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📌 Tarefas Oficiais',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Complete missões especiais e ganhe mais pontos.',
          style: TextStyle(
            fontSize: 14,
            color: textColor.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 12),
        if (loading)
          const Center(child: CircularProgressIndicator())
        else if (tarefas.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Nenhuma tarefa oficial disponível no momento.',
              style: TextStyle(color: textColor.withValues(alpha: 0.8)),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tarefas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (itemContext, index) {
              final tarefa = tarefas[index];
              final cardGradient = LinearGradient(
                colors:
                    isDark
                        ? const [Color(0xFF111827), Color(0xFF1F2937)]
                        : const [Color(0xFFF5F3FF), Color(0xFFE0EAFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );

              final vencimento = DateFormat(
                'dd/MM',
              ).format(tarefa.dataFinalizacao);

              return Container(
                decoration: BoxDecoration(
                  gradient: cardGradient,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: isDark ? 0.12 : 0.9,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.flag_rounded,
                            color: primaryBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tarefa.titulo,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _ChipInfo(
                                    icon: Icons.star_rounded,
                                    label: '${tarefa.pontos} pts',
                                    background: Colors.amber.withValues(
                                      alpha: 0.14,
                                    ),
                                    iconColor: const Color(0xFFF59E0B),
                                  ),
                                  const SizedBox(width: 8),
                                  _ChipInfo(
                                    icon: Icons.calendar_today_rounded,
                                    label: 'Venc: $vencimento',
                                    background: Colors.red.withValues(
                                      alpha: 0.10,
                                    ),
                                    iconColor: const Color(0xFFEF4444),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (tarefa.descricao.isNotEmpty) ...[
                      Text(
                        tarefa.descricao,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryBlue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        onPressed: () async {
                          final userId = usuarioProvider.usuario?.id ?? '';
                          if (userId.isEmpty) {
                            if (!itemContext.mounted) return;
                            ScaffoldMessenger.of(itemContext).showSnackBar(
                              const SnackBar(
                                content: Text('Erro: usuário não identificado'),
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

                              if (!itemContext.mounted) return;

                              if (sucesso) {
                                final concluiu = await provider.concluirTarefa(
                                  tarefa.id,
                                );

                                if (!itemContext.mounted) return;

                                if (concluiu) {
                                  usuarioProvider.adicionarPontos(
                                    tarefa.pontos,
                                  );

                                  if (!itemContext.mounted) return;

                                  ScaffoldMessenger.of(
                                    itemContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '🎉 Você ganhou ${tarefa.pontos} pontos!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                        child: const Text(
                          'Enviar comprovação',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class _ChipInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color iconColor;

  const _ChipInfo({
    required this.icon,
    required this.label,
    required this.background,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFF111827);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
