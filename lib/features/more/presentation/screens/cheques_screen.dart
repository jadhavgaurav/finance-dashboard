import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChequesScreen extends StatelessWidget {
  const ChequesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Cheques')),
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
                    title: 'Issued',
                    value: '45',
                    color: context.colors.accent,
                    icon: Icons.edit_document,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _StatCard(
                    title: 'Cleared',
                    value: '38',
                    color: context.colors.success,
                    icon: Icons.check_circle,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _StatCard(
                    title: 'Pending',
                    value: '7',
                    color: Colors.orange,
                    icon: Icons.schedule,
                  ),
                ),
              ],
            ),
            const Gap(24),
            Text('Recent Cheques', style: context.typography.title),
            const Gap(16),
            _ChequeCard(
              chequeNumber: 'CHQ-0045',
              payee: 'Tech Solutions Pvt Ltd',
              amount: '₹25,000',
              date: 'Jan 15, 2024',
              status: 'Cleared',
              statusColor: context.colors.success,
            ),
            const Gap(12),
            _ChequeCard(
              chequeNumber: 'CHQ-0044',
              payee: 'Office Supplies Inc',
              amount: '₹8,500',
              date: 'Jan 12, 2024',
              status: 'Pending',
              statusColor: Colors.orange,
            ),
            const Gap(12),
            _ChequeCard(
              chequeNumber: 'CHQ-0043',
              payee: 'Marketing Agency',
              amount: '₹15,000',
              date: 'Jan 10, 2024',
              status: 'Cleared',
              statusColor: context.colors.success,
            ),
            const Gap(12),
            _ChequeCard(
              chequeNumber: 'CHQ-0042',
              payee: 'AWS Cloud Services',
              amount: '₹45,000',
              date: 'Jan 08, 2024',
              status: 'Cleared',
              statusColor: context.colors.success,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
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
      padding: const EdgeInsets.all(12),
      body: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const Gap(8),
          Text(value, style: context.typography.title.copyWith(color: color)),
          const Gap(2),
          Text(title, style: context.typography.caption),
        ],
      ),
    );
  }
}

class _ChequeCard extends StatelessWidget {
  const _ChequeCard({
    required this.chequeNumber,
    required this.payee,
    required this.amount,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  final String chequeNumber;
  final String payee;
  final String amount;
  final String date;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return FinanceCard(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(chequeNumber, style: context.typography.title),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(payee, style: context.typography.body),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: context.typography.caption),
              Text(amount, style: context.typography.title.copyWith(color: context.colors.accent)),
            ],
          ),
        ],
      ),
    );
  }
}
