import 'package:agency_finance/domain/models/goal.dart';

abstract class GoalRepository {
  Future<List<Goal>> getGoals(String companyId);
  Future<void> createGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
  Future<void> deleteGoal(String goalId);
}
