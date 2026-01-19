import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class PortfolioHoldingCard extends StatelessWidget {
  final PortfolioHolding holding;

  const PortfolioHoldingCard({
    super.key,
    required this.holding,
  });

  @override
  Widget build(BuildContext context) {
    final pnlColor = holding.isPositivePnl
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(pnlColor),
            const SizedBox(height: 16),
            _buildMetrics(),
            const SizedBox(height: 12),
            _buildAllocationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color pnlColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                holding.symbol,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${holding.quantity} units',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Formatters.currencyFormatter.format(holding.value),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: pnlColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${Formatters.percentFormatter.format(holding.pnlPercent)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: pnlColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetrics() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildMetricRow(
            'Current Price',
            Formatters.currencyFormatter.format(holding.currentPrice),
          ),
          const SizedBox(height: 8),
          _buildMetricRow(
            'Average Price',
            Formatters.currencyFormatter.format(holding.averagePrice),
          ),
          const SizedBox(height: 8),
          _buildMetricRow(
            'Total P&L',
            Formatters.currencyFormatter.format(holding.pnl),
            valueColor: holding.isPositivePnl
                ? const Color(AppConstants.positiveColor)
                : const Color(AppConstants.negativeColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAllocationBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portfolio Allocation',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${holding.allocation.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: holding.allocation / 100,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }
}
