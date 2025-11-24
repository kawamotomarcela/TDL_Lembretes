import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final StatusTarefa status;
  final String? dateTime;
  final int priority;
  final VoidCallback onChanged;
  final bool alarmeAtivado;
  final ValueChanged<bool> onAlarmeChanged;
  final VoidCallback? onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.priority,
    required this.onChanged,
    required this.alarmeAtivado,
    required this.onAlarmeChanged,
    this.dateTime,
    this.onTap,
  });

  Color _getPriorityColor(int prioridade, ThemeData theme) {
    switch (prioridade) {
      case 2:
        return const Color(0xFFEF4444);
      case 1:
        return const Color(0xFFF59E0B);
      case 0:
        return const Color(0xFF22C55E);
      default:
        return theme.colorScheme.outline;
    }
  }

  String _priorityToText(int prioridade) {
    switch (prioridade) {
      case 0:
        return 'Baixa';
      case 1:
        return 'Média';
      case 2:
        return 'Alta';
      default:
        return 'Desconhecida';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isConcluida = status == StatusTarefa.concluida;
    final isExpirada = status == StatusTarefa.expirada;

    final titleColor =
        isExpirada
            ? const Color(0xFFEF4444)
            : (isConcluida
                ? theme.colorScheme.outline
                : theme.colorScheme.onSurface);

    final subtitleColor = isDark ? Colors.white70 : Colors.grey.shade700;

    final priorityColor = _getPriorityColor(priority, theme);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient:
                isDark
                    ? const LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF111827)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : const LinearGradient(
                      colors: [Color(0xFFF9FAFB), Color(0xFFE5EDFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onChanged,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isConcluida
                              ? const Color(0xFF22C55E)
                              : theme.colorScheme.outline.withValues(
                                alpha: 0.7,
                              ),
                      width: 2,
                    ),
                    color:
                        isConcluida
                            ? const Color(0xFF22C55E)
                            : Colors.transparent,
                  ),
                  child:
                      isConcluida
                          ? const Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.white,
                          )
                          : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration:
                            (isConcluida || isExpirada)
                                ? TextDecoration.lineThrough
                                : null,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (subtitle.isNotEmpty) ...[
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Row(
                      children: [
                        if (dateTime != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isExpirada
                                      ? const Color(0xFFFEF2F2)
                                      : const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 15,
                                  color:
                                      isExpirada
                                          ? const Color(0xFFDC2626)
                                          : const Color(0xFF0EA5E9),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  dateTime!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isExpirada
                                            ? const Color(0xFFB91C1C)
                                            : const Color(0xFF0369A1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: priorityColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _priorityToText(priority),
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: priorityColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alarme',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Switch(
                    value: alarmeAtivado,
                    onChanged: onAlarmeChanged,

                    thumbColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return theme.colorScheme.primary;
                      }
                      return Colors.grey;
                    }),

                    trackColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return theme.colorScheme.primary.withValues(alpha: 0.4);
                      }
                      return Colors.grey.withValues(alpha: 0.3);
                    }),

                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
