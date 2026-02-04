import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/invoice.dart';
import 'package:agency_finance/features/more/presentation/screens/bank_account_detail_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/company_detail_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/help_support_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/invoice_detail_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/organization_details_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/profile_details_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/security_settings_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/subscription_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/team_management_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/vendor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompaniesScreen extends ConsumerWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesAsync = FutureProvider((ref) => ref.watch(companyRepositoryProvider).getCompanies());
    final state = ref.watch(companiesAsync);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Companies')),
      body: state.when(
        data: (companies) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: companies.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final company = companies[index];
            return FinanceCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CompanyDetailScreen(company: company)),
                );
              },
              body: Row(
                children: [
                   CircleAvatar(
                     backgroundColor: context.colors.accent.withValues(alpha: 0.1),
                     child: Text(company.name[0], style: TextStyle(color: context.colors.accent)),
                   ),
                   const Gap(16),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(company.name, style: context.typography.title),
                         Text(company.address ?? 'No address', style: context.typography.bodySmall),
                       ],
                     ),
                   ),
                   const Icon(Icons.chevron_right),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BankAccountsScreen extends ConsumerWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now using c1 as default company for mock
    final accountsAsync = FutureProvider((ref) => ref.watch(companyRepositoryProvider).getBankAccounts('c1'));
    final state = ref.watch(accountsAsync);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Bank Accounts')),
      body: state.when(
        data: (accounts) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: accounts.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final account = accounts[index];
            return FinanceCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => BankAccountDetailScreen(account: account)),
                );
              },
              body: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.colors.border),
                    ),
                    child: const Icon(Icons.account_balance),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(account.bankName, style: context.typography.title),
                        Text('**** ${account.accountNumberLast4}', style: context.typography.bodySmall),
                      ],
                    ),
                  ),
                  Text(
                    '₹${account.currentBalance.toStringAsFixed(0)}',
                    style: context.typography.title.copyWith(color: context.colors.accent),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}


class VendorsScreen extends ConsumerWidget {
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorsAsync = FutureProvider((ref) => ref.watch(companyRepositoryProvider).getVendors('c1'));
    final state = ref.watch(vendorsAsync);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Vendors')),
      body: state.when(
        data: (vendors) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vendors.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final vendor = vendors[index];
            return FinanceCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => VendorDetailScreen(vendor: vendor)),
                );
              },
              body: Row(
                children: [
                  CircleAvatar(
                     backgroundColor: context.colors.surface,
                     child: Icon(Icons.business, color: context.colors.textSecondary),
                   ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vendor.name, style: context.typography.title),
                        Text(vendor.phone ?? vendor.email ?? 'No contact', style: context.typography.bodySmall),
                      ],
                    ),
                  ),
                  if (vendor.isVerified)
                    const Icon(Icons.verified, color: Colors.blue, size: 18),
                   const Gap(8),
                   const Icon(Icons.chevron_right),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InvoicesListScreen extends ConsumerWidget {
  const InvoicesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = FutureProvider((ref) => ref.watch(invoiceRepositoryProvider).getInvoices('c1'));
    final state = ref.watch(invoicesAsync);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Invoices')),
      body: state.when(
        data: (invoices) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: invoices.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            return FinanceCard(
              onTap: () {
                Navigator.of(context).push(
                   MaterialPageRoute(builder: (_) => InvoiceDetailScreen(invoice: invoice)),
                );
              },
              body: Row(
                children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(invoice.invoiceNumber, style: context.typography.title),
                         Text('Due: ${invoice.dueDate.toString().split(' ')[0]}', style: context.typography.bodySmall),
                       ],
                     ),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Text(
                         '₹${invoice.amount.toStringAsFixed(0)}',
                         style: context.typography.title,
                       ),
                       _InvoiceStatusTag(status: invoice.status),
                     ],
                   ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}

class _InvoiceStatusTag extends StatelessWidget {
  const _InvoiceStatusTag({required this.status});
  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case InvoiceStatus.paid:
        color = Colors.green;
      case InvoiceStatus.unpaid:
        color = Colors.orange;
      case InvoiceStatus.overdue:
        color = Colors.red;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsGroup(
            title: 'Profile',
            children: [
              _SettingsTile(
                icon: Icons.person_outline,
                title: 'Personal Info',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileDetailsScreen()));
                },
              ),
              _SettingsTile(
                icon: Icons.security,
                title: 'Security',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()));
                },
              ),
            ],
          ),
          const Gap(24),
          _SettingsGroup(
            title: 'Organization',
            children: [
              _SettingsTile(
                icon: Icons.business,
                title: 'Organization Details',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrganizationDetailsScreen()));
                },
              ),
              _SettingsTile(
                icon: Icons.people_outline,
                title: 'Team Members',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TeamManagementScreen()));
                },
              ),
               _SettingsTile(
                icon: Icons.subscriptions,
                title: 'Subscriptions',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
                },
              ),
            ],
          ),
          const Gap(24),
          _SettingsGroup(
            title: 'App',
            children: [
              _SettingsTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                onTap: () {
                   // Notifications screen is already accessible from home, but we can add it here too
                },
              ),
              _SettingsTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
                },
              ),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Appearance',
                trailing: Text('System', style: context.typography.bodySmall),
                onTap: () {},
              ),
            ],
          ),
          const Gap(32),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: context.typography.caption.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.border),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap, this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.textSecondary, size: 20),
      title: Text(title, style: context.typography.body),
      trailing: trailing ?? Icon(Icons.chevron_right, color: context.colors.textTertiary, size: 20),
      onTap: onTap,
    );
  }
}
