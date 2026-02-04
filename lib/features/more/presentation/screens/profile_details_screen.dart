import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Personal Info')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
            ),
            const Gap(8),
            TextButton(onPressed: () {}, child: const Text('Change Photo')),
            const Gap(24),
            _buildTextField(context, 'Full Name', 'John Doe', Icons.person_outline),
            const Gap(16),
            _buildTextField(context, 'Email Address', 'john.doe@agency.com', Icons.email_outlined),
            const Gap(16),
            _buildTextField(context, 'Phone Number', '+91 98765 43210', Icons.phone_outlined),
            const Gap(32),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () {},
                label: 'Save Changes',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String initialValue, IconData icon) {
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
            prefixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
