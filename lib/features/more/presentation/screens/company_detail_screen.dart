import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/company.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({required this.company, super.key});
  final Company company;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Company Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                children: [
                   CircleAvatar(
                     radius: 40,
                     backgroundColor: colors.accent.withValues(alpha: 0.1),
                     child: Text(
                       company.name[0],
                       style: typography.display.copyWith(color: colors.accent, fontSize: 32),
                     ),
                   ),
                   const Gap(16),
                   Text(company.name, style: typography.display.copyWith(fontSize: 24)),
                   const Gap(4),
                   Text(company.id, style: typography.caption),
                ],
              ),
            ),
            const Gap(16),
            FinanceCard(
              header: Text('Information', style: typography.title),
              body: Column(
                children: [
                  _InfoRow(label: 'Address', value: company.address ?? '-'),
                  const Divider(height: 24),
                  _InfoRow(label: 'PAN', value: company.pan ?? '-'),
                  const Divider(height: 24),
                  _InfoRow(label: 'GSTIN', value: company.gstin ?? '-'),
                  const Divider(height: 24),
                  _InfoRow(label: 'Currency', value: company.currency),
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
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Edit Details'),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: context.typography.caption),
        ),
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
