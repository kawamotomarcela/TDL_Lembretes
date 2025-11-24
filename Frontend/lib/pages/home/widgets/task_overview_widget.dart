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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const primaryBlue = Color(0xFF1976D2);

    final titleColor = isDark ? Colors.white : primaryBlue;

    final total = emAndamento + concluidas + expiradas;

    final bgGradient = LinearGradient(
      colors:
          isDark
              ? const [Color(0xFF111827), Color(0xFF1F2937)]
              : const [Color(0xFFE0EAFF), Color(0xFFE5E7EB)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF6B7280);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.pie_chart_rounded,
                  size: 22,
                 color: titleColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visão geral das tarefas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      total > 0
                          ? '$total tarefas no total'
                          : 'Nenhuma tarefa cadastrada ainda',
                      style: TextStyle(fontSize: 13, color: subtitleColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Gráfico
          SizedBox(
            height: 210,
            child:
                total == 0
                    ? Center(
                      child: Text(
                        'Crie suas primeiras tarefas\npara visualizar o gráfico.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: subtitleColor),
                      ),
                    )
                    : PieChart(
                      PieChartData(
                        sections: _buildSections(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 4,
                        startDegreeOffset: -90,
                      ),
                    ),
          ),

          if (total > 0) ...[
            const SizedBox(height: 14),
            Center(
              child: Text(
                '$total tarefas no período',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildLegend(titleColor),
          ],
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final total = emAndamento + concluidas + expiradas;
    final hasData = total > 0;

    double percent(int value) => total == 0 ? 0.0 : (value / total) * 100.0;

    // Placeholder se não tiver dados
    if (!hasData) {
      return [
        PieChartSectionData(
          value: 1,
          color: Colors.amber,
          title: '',
          radius: 48,
        ),
        PieChartSectionData(
          value: 1,
          color: Colors.green,
          title: '',
          radius: 48,
        ),
        PieChartSectionData(
          value: 1,
          color: Colors.redAccent,
          title: '',
          radius: 48,
        ),
      ];
    }

    return [
      PieChartSectionData(
        value: emAndamento.toDouble(),
        color: const Color(0xFFFBBF24),
        title: '${percent(emAndamento).toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
      PieChartSectionData(
        value: concluidas.toDouble(),
        color: const Color(0xFF22C55E),
        title: '${percent(concluidas).toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
      PieChartSectionData(
        value: expiradas.toDouble(),
        color: const Color(0xFFEF4444),
        title: '${percent(expiradas).toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    ];
  }

  Widget _buildLegend(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FittedBox(
        fit: BoxFit.scaleDown, // diminui a escala se não couber
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LegendItem(
              color: const Color(0xFFFBBF24),
              title: 'Em andamento',
              textColor: textColor,
            ),
            const SizedBox(width: 8),
            _LegendItem(
              color: const Color(0xFF22C55E),
              title: 'Concluídas',
              textColor: textColor,
            ),
            const SizedBox(width: 8),
            _LegendItem(
              color: const Color(0xFFEF4444),
              title: 'Expiradas',
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final Color textColor;

  const _LegendItem({
    required this.color,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
