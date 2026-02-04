import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/domain/models/budget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BudgetController extends AsyncNotifier<List<Budget>> {
  @override
  FutureOr<List<Budget>> build() async {
    return _fetchBudgets();
  }

  Future<List<Budget>> _fetchBudgets() async {
    return ref.read(budgetRepositoryProvider).getBudgets('c1');
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchBudgets);
  }
}

final budgetControllerProvider = AsyncNotifierProvider<BudgetController, List<Budget>>(BudgetController.new);
