import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrganizationDetailsScreen extends StatelessWidget {
  const OrganizationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Organization Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(context, 'Company Name', 'Acme Agency', Icons.business),
            const Gap(16),
            _buildTextField(context, 'Tax ID / PAN', 'ABCDE1234F', null),
            const Gap(16),
            _buildTextField(context, 'GSTIN', '29ABCDE1234F1Z5', null),
            const Gap(16),
            _buildTextArea(context, 'Address', '123 Tech Park, Bangalore'),
            const Gap(32),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () {},
                label: 'Update Details',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String initialValue, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colors.textSecondary,
          ),
        ),
        const Gap(8),
        TextFormField(
          initialValue: initialValue,
          style: context.typography.body,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(BuildContext context, String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colors.textSecondary,
          ),
        ),
        const Gap(8),
        TextFormField(
          initialValue: initialValue,
          maxLines: 3,
          style: context.typography.body,
        ),
      ],
    );
  }
}
