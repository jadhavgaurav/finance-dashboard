import 'package:agency_finance/domain/models/budget.dart';

abstract class BudgetRepository {
  Future<List<Budget>> getBudgets(String companyId);
  Future<void> createBudget(Budget budget);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(String budgetId);
}
