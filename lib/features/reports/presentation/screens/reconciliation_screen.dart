import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReconciliationScreen extends StatelessWidget {
  const ReconciliationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Reconciliation Status')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Matched',
                    value: '156',
                    color: context.colors.success,
                    icon: Icons.check_circle,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: _StatCard(
                    title: 'Unmatched',
                    value: '12',
                    color: context.colors.error,
                    icon: Icons.cancel,
                  ),
                ),
              ],
            ),
            const Gap(24),
            Text('Unmatched Transactions', style: context.typography.title),
            const Gap(16),
            _UnmatchedItemCard(
              description: 'Bank Transfer - HDFC',
              amount: '₹25,000',
              date: 'Jan 15, 2024',
            ),
            const Gap(12),
            _UnmatchedItemCard(
              description: 'Payment to Vendor',
              amount: '₹8,500',
              date: 'Jan 12, 2024',
            ),
            const Gap(12),
            _UnmatchedItemCard(
              description: 'Cash Deposit',
              amount: '₹15,000',
              date: 'Jan 10, 2024',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FinanceCard(
      body: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const Gap(8),
          Text(value, style: context.typography.display.copyWith(color: color)),
          const Gap(4),
          Text(title, style: context.typography.bodySmall),
        ],
      ),
    );
  }
}

class _UnmatchedItemCard extends StatelessWidget {
  const _UnmatchedItemCard({
    required this.description,
    required this.amount,
    required this.date,
  });

  final String description;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return FinanceCard(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.warning_amber, color: context.colors.error, size: 20),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: context.typography.body),
                Text(date, style: context.typography.caption),
              ],
            ),
          ),
          Text(amount, style: context.typography.title),
        ],
      ),
    );
  }
}
