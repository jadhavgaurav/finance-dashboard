import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/domain/models/transaction.dart';
import 'package:flutter/material.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions({
    required String companyId,
    DateTimeRange? dateRange,
    TransactionStatus? statusFilter,
  });
  
  Future<Transaction?> getTransaction(String id);
  Future<void> createTransaction(Transaction transaction);
  Future<void> updateStatus(String id, TransactionStatus status);
}
