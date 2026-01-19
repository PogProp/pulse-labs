import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/portfolio_model.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/number_formatters.dart';

class PortfolioPerformanceChart extends StatelessWidget {
  final PortfolioPerformance performance;
  final Function(String) onTimeframeChanged;
  final String selectedTimeframe;

  const PortfolioPerformanceChart({
    super.key,
    required this.performance,
    required this.onTimeframeChanged,
    required this.selectedTimeframe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPositive = performance.summary.isPositiveReturn;
    final returnColor = isPositive
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(returnColor),
            const SizedBox(height: 20),
            _buildTimeframeSelector(),
            const SizedBox(height: 20),
            _buildChart(context, theme, isDark, isPositive),
            const SizedBox(height: 16),
            _buildSummary(theme, isDark, returnColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color returnColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Performance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: returnColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${Formatters.percentFormatter.format(performance.summary.totalReturn)}%',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: returnColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    final timeframes = ['7d', '30d', '90d', '1y'];

    return Row(
      children: timeframes.map((timeframe) {
        final isSelected = timeframe == selectedTimeframe;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(timeframe),
            selected: isSelected,
            onSelected: (_) => onTimeframeChanged(timeframe),
            selectedColor: Colors.blue,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChart(BuildContext context, ThemeData theme, bool isDark, bool isPositive) {
    if (performance.data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No data available'),
        ),
      );
    }

    final spots = performance.data.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.value,
      );
    }).toList();

    final minValue = performance.data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final maxValue = performance.data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final valueRange = maxValue - minValue;
    final padding = valueRange * 0.1;

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: valueRange / 4,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withValues(alpha: 0.2),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (performance.data.length / 4).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= performance.data.length) {
                    return const Text('');
                  }
                  final date = performance.data[index].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${date.month}/${date.day}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: valueRange / 4,
                getTitlesWidget: (value, meta) {
                  return Text(
                    formatLargeCurrency(value),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          minX: 0,
          maxX: (performance.data.length - 1).toDouble(),
          minY: minValue - padding,
          maxY: maxValue + padding,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: isPositive ? const Color(AppConstants.positiveColor) : const Color(AppConstants.negativeColor),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (isPositive
                    ? const Color(AppConstants.positiveColor)
                    : const Color(AppConstants.negativeColor))
                    .withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.x.toInt();
                  if (index < 0 || index >= performance.data.length) {
                    return null;
                  }
                  final point = performance.data[index];
                  return LineTooltipItem(
                    '${Formatters.currencyFormatter.format(point.value)}\n${Formatters.percentFormatter.format(point.pnlPercent)}%',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(ThemeData theme, bool isDark, Color returnColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            theme,
            'Start Value',
            Formatters.currencyFormatter.format(performance.summary.startValue),
          ),
          Container(
            width: 1,
            height: 30,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          _buildSummaryItem(
            theme,
            'End Value',
            Formatters.currencyFormatter.format(performance.summary.endValue),
          ),
          Container(
            width: 1,
            height: 30,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          _buildSummaryItem(
            theme,
            'Total Return',
            '${Formatters.percentFormatter.format(performance.summary.totalReturn)}%',
            valueColor: returnColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(ThemeData theme, String label, String value, {Color? valueColor}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
