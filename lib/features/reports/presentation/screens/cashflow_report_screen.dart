import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CashflowReportScreen extends StatelessWidget {
  const CashflowReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Cashflow Statement')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FinanceCard(
              header: Text('Inflow vs Outflow', style: typography.title),
              body: const Column(
                children: [
                  Gap(100), // Placeholder for Chart
                  Center(child: Text('Cashflow Chart Placeholder')),
                  Gap(100),
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('Monthly Summary', style: typography.title),
              body: Column(
                children: [
                   const _SummaryRow(label: 'Total Inflow', value: '₹5,00,000', color: Colors.green),
                   const Divider(height: 24),
                   const _SummaryRow(label: 'Total Outflow', value: '₹3,20,000', color: Colors.red),
                   const Divider(height: 24),
                   _SummaryRow(label: 'Net Cashflow', value: '₹1,80,000', color: colors.accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.typography.body),
        Text(value, style: context.typography.title.copyWith(color: color)),
      ],
    );
  }
}
