import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('How can we help you?', style: context.typography.display),
          const Gap(24),
          _HelpTile(
            icon: Icons.description_outlined,
            title: 'Documentation',
            subtitle: 'Read our guides and tutorials',
            onTap: () {},
          ),
          const Gap(16),
          _HelpTile(
            icon: Icons.chat_bubble_outline,
            title: 'Live Chat',
            subtitle: 'Talk to our support team',
            onTap: () {},
          ),
          const Gap(16),
          _HelpTile(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'Get response within 24 hours',
            onTap: () {},
          ),
          const Gap(32),
          Text('FAQ', style: context.typography.title),
          const Gap(16),
          const _FaqItem(
            question: 'How do I connect my bank account?',
            answer: 'You can connect your bank account from the Bank Accounts screen under the More tab.',
          ),
          const _FaqItem(
            question: 'How do I export my reports?',
            answer: 'Go to the Reports tab, select the report you want, and use the export icon at the top right.',
          ),
        ],
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.border),
      ),
      leading: Icon(icon, color: context.colors.accent),
      title: Text(title, style: context.typography.body),
      subtitle: Text(subtitle, style: context.typography.bodySmall),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(question, style: context.typography.body.copyWith(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(answer, style: context.typography.bodySmall),
        ),
      ],
    );
  }
}
