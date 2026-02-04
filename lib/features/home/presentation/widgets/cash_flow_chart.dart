import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CashFlowChart extends StatelessWidget {
  const CashFlowChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cash Flow Trend', style: typography.title),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontSize: 10, color: Colors.grey);
                          return SideTitleWidget(
                            meta: meta,
                            child: Text('Day ${value.toInt()}', style: style),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(1, 10000),
                        FlSpot(2, 35000),
                        FlSpot(3, 15000),
                        FlSpot(4, 50000),
                        FlSpot(5, 40000),
                        FlSpot(6, 60000),
                        FlSpot(7, 55000),
                      ],
                      isCurved: true,
                      color: colors.success,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: colors.success.withValues(alpha: 0.1),
                      ),
                    ),
                    LineChartBarData(
                      spots: const [
                        FlSpot(1, 15000),
                        FlSpot(2, 20000),
                        FlSpot(3, 25000),
                        FlSpot(4, 10000),
                        FlSpot(5, 30000),
                        FlSpot(6, 20000),
                        FlSpot(7, 25000),
                      ],
                      isCurved: true,
                      color: colors.error,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(color: colors.success, label: 'Cash In'),
                const SizedBox(width: 16),
                _LegendItem(color: colors.error, label: 'Cash Out'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
