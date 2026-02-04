import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardState {

  DashboardState({
    required this.totalCashBalance,
    required this.cashIn,
    required this.cashOut,
    required this.recentActivity,
  });
  final double totalCashBalance;
  final double cashIn;
  final double cashOut;
  final List<Transaction> recentActivity;
}

class DashboardController extends AsyncNotifier<DashboardState> {
  @override
  FutureOr<DashboardState> build() async {
    return _fetchDashboardData();
  }

  Future<DashboardState> _fetchDashboardData() async {
    // Mock company ID for now
    const companyId = 'c1'; 
    final transactions = await ref.watch(transactionRepositoryProvider).getTransactions(companyId: companyId);
    final bankAccounts = await ref.watch(companyRepositoryProvider).getBankAccounts(companyId);

    // Calculate totals
    final double bankBalance = bankAccounts.fold(0, (sum, acc) => sum + acc.currentBalance);
    // Add fake cash balance
    final double totalBalance = bankBalance + 50000; 

    double inTotal = 0;
    double outTotal = 0;
    
    // Simple logic for month to date
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month);
    
    for (final tx in transactions) {
      if (tx.date.isAfter(startOfMonth)) {
        if (tx.direction == TransactionDirection.incoming && tx.status == TransactionStatus.posted) {
          inTotal += tx.amount;
        } else if (tx.direction == TransactionDirection.outgoing && tx.status == TransactionStatus.posted) {
          outTotal += tx.amount;
        }
      }
    }

    final recent = transactions.take(10).toList();

    return DashboardState(
      totalCashBalance: totalBalance,
      cashIn: inTotal,
      cashOut: outTotal,
      recentActivity: recent,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchDashboardData);
  }
}

final dashboardControllerProvider = AsyncNotifierProvider<DashboardController, DashboardState>(DashboardController.new);
