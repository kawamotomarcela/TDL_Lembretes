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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
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
          _buildLegend(),
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

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: const [
        _LegendItem(color: Colors.amber, text: 'Em Andamento'),
        _LegendItem(color: Colors.green, text: 'Concluídas'),
        _LegendItem(color: Colors.redAccent, text: 'Expiradas'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
