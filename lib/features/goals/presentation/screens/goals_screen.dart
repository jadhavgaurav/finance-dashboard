import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/goal.dart';
import 'package:agency_finance/features/goals/presentation/controllers/goal_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalControllerProvider);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Savings Goals')),
      body: state.when(
        data: (goals) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: goals.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final goal = goals[index];
            return _GoalCard(goal: goal);
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

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal});
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return FinanceCard(
      onTap: () {
        // Navigate to detail
      },
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              goal.icon ?? '💰',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(goal.name, style: context.typography.title),
                const Gap(4),
                LinearProgressIndicator(
                  value: goal.progress,
                  backgroundColor: context.colors.border,
                  color: context.colors.accent,
                  borderRadius: BorderRadius.circular(4),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${goal.currentAmount.toStringAsFixed(0)} / ₹${goal.targetAmount.toStringAsFixed(0)}',
                      style: context.typography.bodySmall,
                    ),
                    Text(
                      '${(goal.progress * 100).toStringAsFixed(0)}%',
                      style: context.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
