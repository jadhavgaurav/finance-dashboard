import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:agency_finance/domain/models/budget.dart';
import 'package:agency_finance/features/budget/presentation/controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetControllerProvider);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Budgets')),
      body: state.when(
        data: (budgets) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: budgets.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final budget = budgets[index];
            return _BudgetCard(budget: budget);
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

class _BudgetCard extends StatelessWidget {
  const _BudgetCard({required this.budget});
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final isOverBudget = budget.spent > budget.amount;
    final color = isOverBudget ? context.colors.error : context.colors.accent;

    return FinanceCard(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(budget.categoryName, style: context.typography.title),
              Text(
                '₹${budget.amount.toStringAsFixed(0)}',
                style: context.typography.title,
              ),
            ],
          ),
          const Gap(8),
          LinearProgressIndicator(
            value: budget.progress,
            backgroundColor: context.colors.border,
            color: color,
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: ₹${budget.spent.toStringAsFixed(0)}',
                style: context.typography.bodySmall.copyWith(
                  color: isOverBudget ? context.colors.error : null,
                ),
              ),
              Text(
                budget.remaining >= 0
                    ? '₹${budget.remaining.toStringAsFixed(0)} left'
                    : '₹${budget.remaining.abs().toStringAsFixed(0)} over',
                style: context.typography.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isOverBudget ? context.colors.error : context.colors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
