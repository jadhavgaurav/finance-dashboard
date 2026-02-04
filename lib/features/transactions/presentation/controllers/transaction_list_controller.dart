import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionListFilter {

  const TransactionListFilter({
    this.searchQuery,
    this.status,
    this.dateRange,
  });
  final String? searchQuery;
  final TransactionStatus? status;
  final DateTimeRange? dateRange;

  TransactionListFilter copyWith({
    String? searchQuery,
    TransactionStatus? status,
    DateTimeRange? dateRange,
  }) {
    return TransactionListFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}

class TransactionListController extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionListController(this._ref) : super(const AsyncLoading()) {
    _fetchTransactions();
  }

  final Ref _ref;
  TransactionListFilter _filter = const TransactionListFilter();

  TransactionListFilter get filter => _filter;

  Future<void> _fetchTransactions() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      const companyId = 'c1'; // Mock
      final allTxs = await _ref.read(transactionRepositoryProvider).getTransactions(
            companyId: companyId,
            statusFilter: _filter.status,
            dateRange: _filter.dateRange,
          );
      
      // Client side search for mock
      if (_filter.searchQuery != null && _filter.searchQuery!.isNotEmpty) {
        final q = _filter.searchQuery!.toLowerCase();
        return allTxs.where((t) => 
          (t.counterpartyName?.toLowerCase().contains(q) ?? false) ||
          (t.referenceNumber?.toLowerCase().contains(q) ?? false)
        ).toList();
      }
      return allTxs;
    });
  }

  void updateSearch(String query) {
    _filter = _filter.copyWith(searchQuery: query);
    _fetchTransactions();
  }

  void updateStatusFilter(TransactionStatus? status) {
    _filter = _filter.copyWith(status: status);
    _fetchTransactions();
  }
  
  void updateDateRange(DateTimeRange? range) {
    _filter = _filter.copyWith(dateRange: range);
    _fetchTransactions();
  }
}

final transactionListControllerProvider = StateNotifierProvider<TransactionListController, AsyncValue<List<Transaction>>>(TransactionListController.new);
