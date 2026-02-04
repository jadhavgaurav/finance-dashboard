import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Security')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SecurityTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {},
          ),
          const Divider(),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: Text('Biometric Login', style: context.typography.body),
            subtitle: Text('Use FaceID or Fingerprint', style: context.typography.bodySmall),
            secondary: Icon(Icons.fingerprint, color: context.colors.textSecondary),
          ),
          const Divider(),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            title: Text('Two-Factor Authentication', style: context.typography.body),
            subtitle: Text('Extra layer of security', style: context.typography.bodySmall),
            secondary: Icon(Icons.security, color: context.colors.textSecondary),
          ),
          const Divider(),
          _SecurityTile(
            icon: Icons.devices,
            title: 'Active Sessions',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SecurityTile extends StatelessWidget {
  const _SecurityTile({required this.icon, required this.title, required this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.textSecondary),
      title: Text(title, style: context.typography.body),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
