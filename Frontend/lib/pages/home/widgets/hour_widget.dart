import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourWidget extends StatefulWidget {
  const HourWidget({super.key});

  @override
  State<HourWidget> createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  late DateTime _agora;

  @override
  void initState() {
    super.initState();
    _agora = DateTime.now();
    _atualizarHoraPeriodicamente();
  }

  void _atualizarHoraPeriodicamente() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _agora = DateTime.now();
        });
        _atualizarHoraPeriodicamente();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final horaFormatada = DateFormat('dd/MM/yyyy - HH:mm:ss').format(_agora);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey.shade800 : Colors.white;
    final primaryTextColor = theme.colorScheme.onSurface;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.access_time, color: primaryTextColor, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hora atual',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  horaFormatada,
                  style: TextStyle(fontSize: 16, color: primaryTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

