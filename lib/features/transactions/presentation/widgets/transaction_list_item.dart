import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/status_pill.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    required this.transaction,
    this.onTap,
    this.dense = false,
    super.key,
  });

  final Transaction transaction;
  final VoidCallback? onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.colors;
    final tx = transaction;

    return ListTile(
      onTap: onTap,
      dense: dense,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: dense ? 16 : 20,
        backgroundColor: tx.direction == TransactionDirection.incoming
            ? colors.success.withValues(alpha: 0.1)
            : colors.surfaceHighlight,
        child: Icon(
          _getIconForMode(tx.mode),
          color: tx.direction == TransactionDirection.incoming
              ? colors.success
              : colors.textSecondary,
          size: dense ? 16 : 20,
        ),
      ),
      title: Text(
        tx.counterpartyName ?? 'Unknown Party',
        style: typography.body.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            DateFormat.MMMd().format(tx.date),
            style: typography.caption,
          ),
          if (!dense && tx.referenceNumber != null) ...[
            const SizedBox(height: 2),
            Text(
              'Ref: ${tx.referenceNumber}',
              style: typography.caption.copyWith(fontSize: 10),
            ),
          ],
        ],
      ),
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
          StatusPill(status: tx.status),
        ],
      ),
    );
  }

  IconData _getIconForMode(PaymentMode mode) {
    switch (mode) {
      case PaymentMode.cash:
        return Icons.attach_money;
      case PaymentMode.cheque:
        return Icons.subtitles; // Looks like a cheque
      case PaymentMode.rtgs:
      case PaymentMode.neft:
      case PaymentMode.imps:
        return Icons.account_balance;
      case PaymentMode.pfms:
        return Icons.assured_workload;
    }
  }
}
