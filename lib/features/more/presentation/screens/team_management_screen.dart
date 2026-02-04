import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TeamManagementScreen extends StatelessWidget {
  const TeamManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Team Members')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _MemberTile(
            name: 'John Doe',
            role: 'Admin',
            email: 'john.doe@agency.com',
            imageUrl: 'https://i.pravatar.cc/150?u=1',
          ),
          Gap(16),
          _MemberTile(
            name: 'Jane Smith',
            role: 'Editor',
            email: 'jane.smith@agency.com',
            imageUrl: 'https://i.pravatar.cc/150?u=2',
          ),
          Gap(16),
          _MemberTile(
            name: 'Mike Johnson',
            role: 'Viewer',
            email: 'mike.j@agency.com',
            imageUrl: 'https://i.pravatar.cc/150?u=3',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.name, required this.role, required this.email, required this.imageUrl});
  final String name;
  final String role;
  final String email;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: context.typography.title),
                Text(email, style: context.typography.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.colors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              role.toUpperCase(),
              style: TextStyle(color: context.colors.accent, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
