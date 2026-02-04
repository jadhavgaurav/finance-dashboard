import 'dart:async';

import 'package:agency_finance/data/mocks/mock_data.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/bank_account.dart';
import 'package:agency_finance/domain/models/budget.dart';
import 'package:agency_finance/domain/models/company.dart';
import 'package:agency_finance/domain/models/goal.dart';
import 'package:agency_finance/domain/models/invoice.dart';
import 'package:agency_finance/domain/models/notification.dart';
import 'package:agency_finance/domain/models/subscription.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:agency_finance/domain/models/vendor.dart';
import 'package:agency_finance/domain/repositories/auth_repository.dart';
import 'package:agency_finance/domain/repositories/budget_repository.dart';
import 'package:agency_finance/domain/repositories/company_repository.dart';
import 'package:agency_finance/domain/repositories/goal_repository.dart';
import 'package:agency_finance/domain/repositories/invoice_repository.dart';
import 'package:agency_finance/domain/repositories/notification_repository.dart';
import 'package:agency_finance/domain/repositories/subscription_repository.dart';
import 'package:agency_finance/domain/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthRepository implements AuthRepository {

  MockAuthRepository() {
    _init();
  }
  static const _authKey = 'auth_token';
  final _authStateController = StreamController<bool>.broadcast();
  bool? _isLoggedIn;

  @override
  bool? get currentAuthStatus => _isLoggedIn;

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.containsKey(_authKey);
    _authStateController.add(_isLoggedIn!);
  }

  @override
  Stream<bool> get authStateChanges async* {
    if (_isLoggedIn != null) {
      yield _isLoggedIn!;
    }
    yield* _authStateController.stream;
  }

  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, 'mock_token_$email');
    _isLoggedIn = true;
    _authStateController.add(true);
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
    _isLoggedIn = false;
    _authStateController.add(false);
  }
}

class MockCompanyRepository implements CompanyRepository {
  final List<Company> _companies = MockDataGenerator.generateCompanies();
  final Map<String, List<BankAccount>> _bankAccounts = {
    'c1': MockDataGenerator.generateBankAccounts('c1'),
    'c2': MockDataGenerator.generateBankAccounts('c2'),
  };

  final Map<String, List<Vendor>> _vendors = {
    'c1': MockDataGenerator.generateVendors('c1'),
  };

  @override
  Future<List<Company>> getCompanies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _companies;
  }

  @override
  Future<Company?> getCompany(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _companies.firstWhere((c) => c.id == id);
  }

  @override
  Future<void> createCompany(Company company) async {
    _companies.add(company);
  }

  @override
  Future<bool> hasCompany() async {
    return _companies.isNotEmpty;
  }

  @override
  Future<List<BankAccount>> getBankAccounts(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _bankAccounts[companyId] ?? [];
  }

  @override
  Future<List<Vendor>> getVendors(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _vendors[companyId] ?? [];
  }
}

class MockInvoiceRepository implements InvoiceRepository {
  final Map<String, List<Invoice>> _invoices = {
    'c1': MockDataGenerator.generateInvoices('c1'),
  };

  @override
  Future<List<Invoice>> getInvoices(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _invoices[companyId] ?? [];
  }

  @override
  Future<Invoice?> getInvoice(String id) async {
    return null; // Mock
  }

  @override
  Future<void> createInvoice(Invoice invoice) async {
    // Mock
  }
}

class MockTransactionRepository implements TransactionRepository {
  final List<Transaction> _transactions = MockDataGenerator.generateTransactions('c1'); 

  @override
  Future<List<Transaction>> getTransactions({
    required String companyId,
    DateTimeRange? dateRange,
    TransactionStatus? statusFilter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Simple filter simulation
    return _transactions.where((t) {
      if (t.companyId != companyId) return false;
      if (statusFilter != null && t.status != statusFilter) return false;
      // Date range filter to be implemented
      return true;
    }).toList();
  }

  @override
  Future<Transaction?> getTransaction(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createTransaction(Transaction transaction) async {
    await Future.delayed(const Duration(seconds: 1));
    _transactions.insert(0, transaction);
  }

  @override
  Future<void> updateStatus(String id, TransactionStatus status) async {
    // Immutable style update
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      // Since models are equatable and const, strictly should replace
      // But for mock repo in memory list, we can't easilyCopyWith without a copyWith method
      // Assuming I'll add copyWith later or just hack it for mock
    }
  }
}

class MockBudgetRepository implements BudgetRepository {
  final Map<String, List<Budget>> _budgets = {
    'c1': MockDataGenerator.generateBudgets('c1'),
  };

  @override
  Future<List<Budget>> getBudgets(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _budgets[companyId] ?? [];
  }

  @override
  Future<void> createBudget(Budget budget) async {
    final list = _budgets[budget.companyId] ?? [];
    list.add(budget);
    _budgets[budget.companyId] = list;
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    final list = _budgets[budget.companyId] ?? [];
    final index = list.indexWhere((b) => b.id == budget.id);
    if (index != -1) {
      list[index] = budget;
    }
  }

  @override
  Future<void> deleteBudget(String budgetId) async {
    for (final companyId in _budgets.keys) {
      _budgets[companyId]?.removeWhere((b) => b.id == budgetId);
    }
  }
}

class MockGoalRepository implements GoalRepository {
  final Map<String, List<Goal>> _goals = {
    'c1': MockDataGenerator.generateGoals('c1'),
  };

  @override
  Future<List<Goal>> getGoals(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _goals[companyId] ?? [];
  }

  @override
  Future<void> createGoal(Goal goal) async {
    final list = _goals[goal.companyId] ?? [];
    list.add(goal);
    _goals[goal.companyId] = list;
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    final list = _goals[goal.companyId] ?? [];
    final index = list.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      list[index] = goal;
    }
  }

  @override
  Future<void> deleteGoal(String goalId) async {
     for (final companyId in _goals.keys) {
      _goals[companyId]?.removeWhere((g) => g.id == goalId);
    }
  }
}

class MockNotificationRepository implements NotificationRepository {
  final List<AppNotification> _notifications = MockDataGenerator.generateNotifications();

  @override
  Future<List<AppNotification>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notifications;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    _notifications.removeWhere((n) => n.id == notificationId);
  }
}

class MockSubscriptionRepository implements SubscriptionRepository {
  final Map<String, List<Subscription>> _subscriptions = {
    'c1': MockDataGenerator.generateSubscriptions('c1'),
  };

  @override
  Future<List<Subscription>> getSubscriptions(String companyId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _subscriptions[companyId] ?? [];
  }

  @override
  Future<void> createSubscription(Subscription subscription) async {
     final list = _subscriptions[subscription.companyId] ?? [];
    list.add(subscription);
    _subscriptions[subscription.companyId] = list;
  }

  @override
  Future<void> updateSubscription(Subscription subscription) async {
    final list = _subscriptions[subscription.companyId] ?? [];
    final index = list.indexWhere((s) => s.id == subscription.id);
    if (index != -1) {
      list[index] = subscription;
    }
  }

  @override
  Future<void> deleteSubscription(String subscriptionId) async {
     for (final companyId in _subscriptions.keys) {
      _subscriptions[companyId]?.removeWhere((s) => s.id == subscriptionId);
    }
  }
}
