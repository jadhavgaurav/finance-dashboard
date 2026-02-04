import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionsAsync = FutureProvider((ref) => ref.watch(subscriptionRepositoryProvider).getSubscriptions('c1'));
    final state = ref.watch(subscriptionsAsync);

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Subscriptions')),
      body: state.when(
        data: (subs) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: subs.length,
          separatorBuilder: (_, __) => const Gap(16),
          itemBuilder: (context, index) {
            final sub = subs[index];
            return FinanceCard(
              body: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.colors.surface,
                    child: const Icon(Icons.subscriptions_outlined),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sub.name, style: context.typography.title),
                        Text(
                          'Next billing: ${sub.nextBillingDate.toString().split(' ')[0]}',
                          style: context.typography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${sub.amount.toStringAsFixed(0)}',
                        style: context.typography.title.copyWith(color: context.colors.accent),
                      ),
                      Text(sub.status.name.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
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
    );
  }
}
