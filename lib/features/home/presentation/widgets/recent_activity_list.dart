import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/core/widgets/status_pill.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({
    required this.transactions,
    this.onViewAll,
    super.key,
  });

  final List<Transaction> transactions;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.colors;

    return FinanceCard(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Recent Activity', style: typography.title),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All'),
            ),
        ],
      ),
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: tx.direction == TransactionDirection.incoming
                  ? colors.success.withValues(alpha: 0.1)
                  : colors.background, // Neutral for expense usually or error light
              child: Icon(
                tx.direction == TransactionDirection.incoming
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: tx.direction == TransactionDirection.incoming
                    ? colors.success
                    : colors.textSecondary,
                size: 20,
              ),
            ),
            title: Text(tx.counterpartyName ?? 'Unknown Party', style: typography.body),
            subtitle: Text(DateFormat.MMMd().format(tx.date), style: typography.caption),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${tx.direction == TransactionDirection.incoming ? '+' : '-'} ₹${NumberFormat.compact().format(tx.amount)}',
                  style: typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: tx.direction == TransactionDirection.incoming ? colors.success : colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                StatusPill(status: tx.status), // Maybe too big? Pill handles it.
              ],
            ),
          );
        },
      ),
    );
  }
}
