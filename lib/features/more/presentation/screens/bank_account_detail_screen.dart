import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class BankAccountDetailScreen extends StatelessWidget {
  const BankAccountDetailScreen({required this.account, super.key});
  final BankAccount account;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Account Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.accent, colors.accent.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.bankName, style: typography.title.copyWith(color: Colors.white)),
                  const Gap(8),
                  Text('**** **** **** ${account.accountNumberLast4}', style: typography.body.copyWith(color: Colors.white70)),
                  const Gap(32),
                  Text('Current Balance', style: typography.caption.copyWith(color: Colors.white60)),
                  const Gap(4),
                  Text(
                    '₹${NumberFormat.decimalPattern().format(account.currentBalance)}',
                    style: typography.display.copyWith(color: Colors.white, fontSize: 28),
                  ),
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('Information', style: typography.title),
              body: Column(
                children: [
                  _InfoRow(label: 'Account Type', value: account.accountType),
                  const Divider(height: 24),
                  _InfoRow(label: 'IFSC Code', value: account.ifscCode),
                  const Divider(height: 24),
                  _InfoRow(label: 'Opening Balance', value: '₹${NumberFormat.decimalPattern().format(account.openingBalance)}'),
                  const Divider(height: 24),
                  _InfoRow(label: 'Last Synced', value: account.lastSyncedAt != null ? DateFormat.yMMMd().add_jm().format(account.lastSyncedAt!) : 'Never'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.typography.caption),
        Text(value, style: context.typography.body.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
