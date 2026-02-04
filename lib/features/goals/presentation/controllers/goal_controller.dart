import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/domain/models/goal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoalController extends AsyncNotifier<List<Goal>> {
  @override
  FutureOr<List<Goal>> build() async {
    return _fetchGoals();
  }

  Future<List<Goal>> _fetchGoals() async {
    return ref.read(goalRepositoryProvider).getGoals('c1');
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchGoals);
  }
}

final goalControllerProvider = AsyncNotifierProvider<GoalController, List<Goal>>(GoalController.new);
