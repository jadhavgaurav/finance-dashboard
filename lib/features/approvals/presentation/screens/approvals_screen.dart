import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/features/transactions/presentation/screens/transaction_detail_screen.dart';
import 'package:agency_finance/features/transactions/presentation/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApprovalsScreen extends ConsumerStatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  ConsumerState<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends ConsumerState<ApprovalsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinanceAppBar(
        title: const Text('Approvals'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ApprovalList(status: TransactionStatus.pendingApproval),
          _ApprovalList(status: TransactionStatus.approved), // Mock history
        ],
      ),
    );
  }
}

class _ApprovalList extends ConsumerWidget {
  const _ApprovalList({required this.status});
  final TransactionStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ad-hoc fetch for now, ideally in a controller
    final transactionsFuture = ref.watch(transactionRepositoryProvider).getTransactions(
      companyId: 'c1',
      statusFilter: status,
    );

    return FutureBuilder(
      future: transactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        
        final list = snapshot.data ?? [];
        if (list.isEmpty) return const Center(child: Text('No approvals found'));

        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            return TransactionListItem(
              transaction: list[index],
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionDetailScreen(transaction: list[index])));
              },
            );
          },
        );
      },
    );
  }
}
