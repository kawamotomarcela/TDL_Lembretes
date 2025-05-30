import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskOverviewWidget extends StatelessWidget {
  final int emAndamento;
  final int concluidas;
  final int expiradas;

  const TaskOverviewWidget({
    super.key,
    required this.emAndamento,
    required this.concluidas,
    required this.expiradas,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sections: _buildSections(),
                centerSpaceRadius: 30,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildLegend(textColor),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    return [
      PieChartSectionData(
        value: emAndamento.toDouble(),
        color: Colors.amber,
        title: '$emAndamento',
        radius: 40,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: concluidas.toDouble(),
        color: Colors.green,
        title: '$concluidas',
        radius: 40,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: expiradas.toDouble(),
        color: Colors.redAccent,
        title: '$expiradas',
        radius: 40,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildLegend(Color textColor) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _LegendItem(color: Colors.amber, text: 'Em Andamento', textColor: textColor),
        _LegendItem(color: Colors.green, text: 'Concluídas', textColor: textColor),
        _LegendItem(color: Colors.redAccent, text: 'Expiradas', textColor: textColor),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;

  const _LegendItem({
    required this.color,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }
}

