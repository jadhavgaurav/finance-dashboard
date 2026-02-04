import 'package:agency_finance/core/routing/app_routes.dart';
import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agency_finance/features/more/presentation/screens/cheques_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/help_support_screen.dart';
import 'package:agency_finance/features/reports/presentation/screens/reconciliation_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('More')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _SectionHeader(title: 'Data Management'),
            _MenuItem(
              icon: Icons.business,
              label: 'Companies',
              onTap: () => GoRouter.of(context).go('${AppRoutes.more}/companies'),
            ),
            _MenuItem(
              icon: Icons.account_balance,
              label: 'Bank Accounts',
              onTap: () => GoRouter.of(context).go('${AppRoutes.more}/bank-accounts'),
            ),
            _MenuItem(
              icon: Icons.people_outline,
              label: 'Vendors',
              onTap: () => GoRouter.of(context).go('${AppRoutes.more}/vendors'),
            ),

            const _SectionHeader(title: 'Finance'),
            _MenuItem(
              icon: Icons.receipt_long,
              label: 'Invoices',
              onTap: () => GoRouter.of(context).push('${AppRoutes.more}/invoices'),
            ),
            _MenuItem(
              icon: Icons.credit_card,
              label: 'Cheques',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ChequesScreen()),
              ),
            ),
            _MenuItem(
              icon: Icons.sync,
              label: 'Reconciliation',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ReconciliationScreen()),
              ),
            ),

            const _SectionHeader(title: 'System'),
            _MenuItem(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => GoRouter.of(context).go('${AppRoutes.more}/settings'),
            ),
            _MenuItem(
              icon: Icons.help_outline,
              label: 'Help & Support',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const HelpSupportScreen()),
              ),
            ),

            const Gap(24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout();
              },
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: typography.caption.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.textPrimary),
      title: Text(label, style: context.typography.body),
      trailing: Icon(Icons.chevron_right, size: 20, color: context.colors.textTertiary),
      onTap: onTap,
    );
  }
}
