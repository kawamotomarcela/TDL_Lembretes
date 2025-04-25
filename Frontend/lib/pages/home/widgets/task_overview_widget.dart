import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskOverviewWidget extends StatelessWidget {
  const TaskOverviewWidget({super.key});

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
            height: 150,
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
        value: 12,
        color: Colors.blue,
        title: '12',
        radius: 40,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: 28,
        color: Colors.purple,
        title: '28',
        radius: 40,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.teal,
        title: '20',
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
      _LegendItem(color: Colors.blue, text: 'Pendentes'),
      _LegendItem(color: Colors.purple, text: 'em Andamento'),
      _LegendItem(color: Colors.teal, text: 'Completadas'),
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
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
