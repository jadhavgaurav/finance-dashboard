import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/features/reports/presentation/screens/cashflow_report_screen.dart';
import 'package:agency_finance/features/reports/presentation/screens/category_breakdown_screen.dart';
import 'package:agency_finance/features/reports/presentation/screens/vendor_spend_report_screen.dart';
import 'package:agency_finance/features/reports/presentation/screens/reconciliation_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Reports')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ReportCard(
              title: 'Cashflow Statement',
              icon: Icons.timeline,
              description: 'Inflow vs Outflow over time',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CashflowReportScreen()));
              },
            ),
            const Gap(16),
            _ReportCard(
              title: 'Vendor Spend',
              icon: Icons.store,
              description: 'Top vendors by spend volume',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VendorSpendReportScreen()));
              },
            ),
            const Gap(16),
            _ReportCard(
              title: 'Category Breakdown',
              icon: Icons.pie_chart,
              description: 'Expenses by category',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CategoryBreakdownScreen()));
              },
            ),
            const Gap(16),
            _ReportCard(
              title: 'Reconciliation Status',
              icon: Icons.check_circle_outline,
              description: 'Matched vs Unmatched items',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ReconciliationScreen()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Builder
        },
        label: const Text('Custom Report'),
        icon: const Icon(Icons.add_chart),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return FinanceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colors.accent, size: 28),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: typography.title.copyWith(fontSize: 18)),
                const Gap(4),
                Text(description, style: typography.bodySmall.copyWith(color: colors.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colors.textTertiary),
        ],
      ),
    );
  }
}
