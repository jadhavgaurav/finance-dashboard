import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VendorDetailScreen extends StatelessWidget {
  const VendorDetailScreen({required this.vendor, super.key});
  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Vendor Details')),
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
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colors.surface,
                    child: Icon(Icons.business, size: 40, color: colors.textSecondary),
                  ),
                  const Gap(16),
                  Text(vendor.name, style: typography.title.copyWith(fontSize: 20)),
                  if (vendor.isVerified) ...[
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.verified, color: Colors.blue, size: 16),
                        const Gap(4),
                        Text('Verified Vendor', style: typography.caption.copyWith(color: Colors.blue)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('Contact Information', style: typography.title),
              body: Column(
                children: [
                  _InfoRow(label: 'Email', value: vendor.email ?? '-'),
                  const Divider(height: 24),
                  _InfoRow(label: 'Phone', value: vendor.phone ?? '-'),
                  const Divider(height: 24),
                  _InfoRow(label: 'Tax ID (PAN)', value: vendor.taxId ?? '-'),
                ],
              ),
            ),
            const Gap(16),
            if (vendor.bankName != null)
              FinanceCard(
                header: Text('Banking Details', style: typography.title),
                body: Column(
                  children: [
                    _InfoRow(label: 'Bank Name', value: vendor.bankName!),
                    const Divider(height: 24),
                    _InfoRow(label: 'Account No', value: vendor.bankAccountNo ?? '-'),
                    const Divider(height: 24),
                    _InfoRow(label: 'IFSC Code', value: vendor.ifscCode ?? '-'),
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
        Expanded(
          child: Text(
            value,
            style: context.typography.body.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
