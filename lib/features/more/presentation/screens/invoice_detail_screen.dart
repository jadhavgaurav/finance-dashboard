import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({required this.invoice, super.key});
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Invoice Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                children: [
                   Text('Amount Due', style: typography.caption),
                   const Gap(8),
                   Text(
                     '₹${NumberFormat.decimalPattern().format(invoice.amount)}',
                     style: typography.display.copyWith(fontSize: 32),
                   ),
                   const Gap(16),
                   _InvoiceStatusPill(status: invoice.status),
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('Invoice Details', style: typography.title),
              body: Column(
                children: [
                  _InfoRow(label: 'Invoice #', value: invoice.invoiceNumber),
                  const Divider(height: 24),
                  _InfoRow(label: 'Vendor ID', value: invoice.vendorId),
                  const Divider(height: 24),
                  _InfoRow(label: 'Invoice Date', value: DateFormat.yMMMd().format(invoice.invoiceDate)),
                  const Divider(height: 24),
                  _InfoRow(label: 'Due Date', value: DateFormat.yMMMd().format(invoice.dueDate)),
                  if (invoice.paidAmount > 0) ...[
                    const Divider(height: 24),
                    _InfoRow(label: 'Paid Amount', value: '₹${NumberFormat.decimalPattern().format(invoice.paidAmount)}'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: Row(
          children: [
            if (invoice.status != InvoiceStatus.paid)
              Expanded(
                child: PrimaryButton(
                  label: 'Pay Now',
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceStatusPill extends StatelessWidget {
  const _InvoiceStatusPill({required this.status});
  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case InvoiceStatus.paid: color = Colors.green;
      case InvoiceStatus.unpaid: color = Colors.orange;
      case InvoiceStatus.overdue: color = Colors.red;
      default: color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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
