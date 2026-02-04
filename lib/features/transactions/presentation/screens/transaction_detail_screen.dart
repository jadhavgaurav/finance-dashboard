import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/core/widgets/status_pill.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({required this.transaction, super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final tx = transaction;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Transaction Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Amount Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                children: [
                  Text('Amount', style: typography.caption),
                  const Gap(8),
                  Text(
                    '₹${NumberFormat.decimalPattern().format(tx.amount)}',
                    style: typography.display.copyWith(fontSize: 32),
                  ),
                  const Gap(16),
                  StatusPill(status: tx.status),
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('General Information', style: typography.title),
              body: Column(
                children: [
                   _DetailRow(label: 'Date', value: DateFormat.yMMMd().format(tx.date)),
                   const Divider(height: 24),
                   _DetailRow(label: 'Party', value: tx.counterpartyName ?? '-'),
                   const Divider(height: 24),
                   _DetailRow(label: 'Category', value: tx.categoryId ?? '-'),
                   const Divider(height: 24),
                   _DetailRow(label: 'Payment Mode', value: tx.mode.label),
                   if (tx.referenceNumber != null) ...[
                     const Divider(height: 24),
                     _DetailRow(label: 'Reference', value: tx.referenceNumber!),
                   ],
                ],
              ),
            ),
            const Gap(16),
             if (tx.description != null)
              FinanceCard(
                header: Text('Description', style: typography.title),
                body: Text(tx.description!),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
        child: Row(
          children: [
            if (tx.status == TransactionStatus.pendingApproval) ...[
              Expanded(child: SecondaryButton(label: 'Reject', onPressed: () {})),
              const Gap(16),
              Expanded(child: PrimaryButton(label: 'Approve', onPressed: () {})),
            ],
            if (tx.status == TransactionStatus.posted)
              Expanded(child: DestructiveButton(label: 'Reverse', onPressed: () {})),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: context.colors.textSecondary)),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
