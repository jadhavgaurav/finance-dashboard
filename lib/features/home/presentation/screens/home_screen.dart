import 'package:agency_finance/core/routing/app_router.dart';
import 'package:agency_finance/core/routing/app_routes.dart';
import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/features/home/presentation/controllers/dashboard_controller.dart';
import 'package:agency_finance/features/home/presentation/widgets/cash_flow_chart.dart';
import 'package:agency_finance/features/home/presentation/widgets/dashboard_stats_grid.dart';
import 'package:agency_finance/features/home/presentation/widgets/recent_activity_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: FinanceAppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => ref.read(goRouterProvider).push(AppRoutes.notifications),
          ),
        ],
      ),
      body: stateAsync.when(
        data: (state) => RefreshIndicator(
          onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Today, ${DateTime.now().toString().split(' ')[0]}', style: context.typography.caption),
                const SizedBox(height: 16),
                DashboardStatsGrid(state: state),
                const SizedBox(height: 24),
                const CashFlowChart(),
                const SizedBox(height: 24),
                RecentActivityList(
                  transactions: state.recentActivity,
                  onViewAll: () => ref.read(goRouterProvider).go(AppRoutes.transactions),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
