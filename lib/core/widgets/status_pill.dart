import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({
    required this.status,
    super.key,
  });

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;

    switch (status) {
      case TransactionStatus.draft:
        backgroundColor = colors.surfaceHighlight;
        foregroundColor = colors.textSecondary;
        borderColor = colors.border;
      case TransactionStatus.pendingApproval:
        backgroundColor = colors.warning.withOpacity(0.1);
        foregroundColor = colors.warning;
        borderColor = colors.warning.withOpacity(0.2);
      case TransactionStatus.approved:
        backgroundColor = colors.info.withOpacity(0.1);
        foregroundColor = colors.info;
        borderColor = colors.info.withOpacity(0.2);
      case TransactionStatus.posted:
        backgroundColor = colors.success.withOpacity(0.1);
        foregroundColor = colors.success;
        borderColor = colors.success.withOpacity(0.2);
      case TransactionStatus.failed:
      case TransactionStatus.reversed:
      case TransactionStatus.voided:
        backgroundColor = colors.error.withOpacity(0.1);
        foregroundColor = colors.error;
        borderColor = colors.error.withOpacity(0.2);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        status.label,
        style: typography.caption.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ReconciliationPill extends StatelessWidget {
  const ReconciliationPill({
    required this.status,
    super.key,
  });

  final ReconciliationStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Color foregroundColor;
    Color backgroundColor;

    switch (status) {
      case ReconciliationStatus.matched:
        foregroundColor = colors.success;
        backgroundColor = colors.success.withOpacity(0.1);
      case ReconciliationStatus.unmatched:
        foregroundColor = colors.error;
        backgroundColor = colors.error.withOpacity(0.1);
      case ReconciliationStatus.suggested:
        foregroundColor = colors.info;
        backgroundColor = colors.info.withOpacity(0.1);
      case ReconciliationStatus.ignored:
        foregroundColor = colors.textSecondary;
        backgroundColor = colors.surfaceHighlight;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label.toUpperCase(),
        style: typography.caption.copyWith(
          color: foregroundColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
