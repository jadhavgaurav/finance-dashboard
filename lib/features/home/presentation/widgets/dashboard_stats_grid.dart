import 'package:agency_finance/core/widgets/kpi_stat_tile.dart';
import 'package:agency_finance/features/home/presentation/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardStatsGrid extends StatelessWidget {
  const DashboardStatsGrid({
    required this.state,
    super.key,
  });

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: KPIStatTile(
                label: 'Total Balance',
                value: currencyFormat.format(state.totalCashBalance),
                icon: Icons.account_balance_wallet,
                trend: '+2.5%',
                isPositive: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: KPIStatTile(
                label: 'Cash In (MTD)',
                value: currencyFormat.format(state.cashIn),
                icon: Icons.arrow_downward,
                trend: '+12%',
                isPositive: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KPIStatTile(
                label: 'Cash Out (MTD)',
                value: currencyFormat.format(state.cashOut),
                icon: Icons.arrow_upward,
                trend: '+5%',
                isPositive: false, // Spending increased
              ),
            ),
          ],
        ),
      ],
    );
  }
}
