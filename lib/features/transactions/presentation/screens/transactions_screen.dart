import 'package:agency_finance/core/widgets/app_text_field.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/features/transactions/presentation/controllers/transaction_list_controller.dart';
import 'package:agency_finance/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:agency_finance/features/transactions/presentation/screens/transaction_detail_screen.dart';
import 'package:agency_finance/features/transactions/presentation/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionListControllerProvider);
    final controller = ref.read(transactionListControllerProvider.notifier);
    final filter = controller.filter;

    return Scaffold(
      appBar: FinanceAppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {
            // TODO: Show advanced filters
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTransactionScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppTextField(
                  label: '',
                  hint: 'Search vendor, amount, reference...',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: controller.updateSearch,
                ),
                const Gap(12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: filter.status == null,
                        onSelected: (val) => controller.updateStatusFilter(null),
                      ),
                      const Gap(8),
                      // Dynamic status chips
                      ...TransactionStatus.values.map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(status.label),
                            selected: filter.status == status,
                            onSelected: (val) => controller.updateStatusFilter(val ? status : null),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return const Center(child: Text('No transactions found'));
                }
                return ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return TransactionListItem(
                      transaction: tx,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionDetailScreen(transaction: tx)));
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
