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

  Color _getPriorityColor(int prioridade) {
    switch (prioridade) {
      case 2:
        return Colors.red;
      case 1:
        return Colors.amber;
      case 0:
        return Colors.green;
      default:
        return Colors.grey;
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
    final isConcluida = status == StatusTarefa.concluida;
    final isExpirada = status == StatusTarefa.expirada;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onChanged,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isConcluida ? Colors.green : Colors.grey,
                      width: 2,
                    ),
                    color: isConcluida ? Colors.green : Colors.transparent,
                  ),
                  child: isConcluida
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
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
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: (isConcluida || isExpirada)
                            ? TextDecoration.lineThrough
                            : null,
                        color: isExpirada
                            ? Colors.red
                            : (isConcluida ? Colors.grey : Colors.black),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (dateTime != null) ...[
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.red),
                          const SizedBox(width: 6),
                          Text(
                            dateTime!,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.red,
                            ),
                          ),
                        ],
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getPriorityColor(priority),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _priorityToText(priority),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Alarme', style: TextStyle(fontSize: 12)),
                  Switch(
                    value: alarmeAtivado,
                    onChanged: onAlarmeChanged,
                    activeColor: Colors.blue,
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
