import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String? dateTime;
  final int priority; // agora é int (1 = baixa, 2 = média, 3 = alta)
  final VoidCallback onChanged;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.priority,
    required this.onChanged,
    this.dateTime,
  });

  Color _getPriorityColor() {
    switch (priority) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.amber;
      case 1:
      default:
        return Colors.green;
    }
  }

  String _getPriorityText() {
    switch (priority) {
      case 3:
        return 'Alta';
      case 2:
        return 'Média';
      case 1:
      default:
        return 'Baixa';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDone = status == 'concluída';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            GestureDetector(
              onTap: onChanged,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                  color: isDone ? Colors.green : Colors.transparent,
                ),
                width: 24,
                height: 24,
                child: isDone
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
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      color: isDone ? Colors.grey : Colors.black,
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
                        const Icon(Icons.access_time, size: 16, color: Colors.red),
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
                          color: _getPriorityColor(),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getPriorityText(),
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
          ],
        ),
      ),
    );
  }
}
