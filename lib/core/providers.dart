import 'package:agency_finance/data/repositories/mock_repositories.dart';
import 'package:agency_finance/domain/repositories/auth_repository.dart';
import 'package:agency_finance/domain/repositories/budget_repository.dart';
import 'package:agency_finance/domain/repositories/company_repository.dart';
import 'package:agency_finance/domain/repositories/goal_repository.dart';
import 'package:agency_finance/domain/repositories/invoice_repository.dart';
import 'package:agency_finance/domain/repositories/notification_repository.dart';
import 'package:agency_finance/domain/repositories/subscription_repository.dart';
import 'package:agency_finance/domain/repositories/transaction_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

final authStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  return MockCompanyRepository();
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return MockTransactionRepository();
});

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  return MockInvoiceRepository();
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return MockBudgetRepository();
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return MockGoalRepository();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return MockNotificationRepository();
});

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return MockSubscriptionRepository();
});
