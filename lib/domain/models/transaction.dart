import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.companyId,
    required this.date,
    required this.amount,
    required this.currency,
    required this.direction,
    required this.status,
    required this.mode,
    required this.reconciliationStatus,
    this.vendorId,
    this.counterpartyName,
    this.categoryId,
    this.description,
    this.referenceNumber, // UTR, Cheque No, PFMS Ref
    this.bankAccountId, // If bank involved
    this.invoiceIds = const [],
    this.attachmentUrls = const [],
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  final String id;
  final String companyId;
  final DateTime date;
  final double amount;
  final String currency;
  final TransactionDirection direction;
  final TransactionStatus status;
  final PaymentMode mode;
  @JsonKey(name: 'reconciliation_status')
  final ReconciliationStatus reconciliationStatus;
  
  @JsonKey(name: 'vendor_id')
  final String? vendorId; // Null if ad-hoc
  @JsonKey(name: 'counterparty_name')
  final String? counterpartyName; // Display name
  
  @JsonKey(name: 'category_id')
  final String? categoryId;
  final String? description;
  
  @JsonKey(name: 'reference_number')
  final String? referenceNumber;
  
  @JsonKey(name: 'bank_account_id')
  final String? bankAccountId;
  
  @JsonKey(name: 'invoice_ids')
  final List<String> invoiceIds;
  
  @JsonKey(name: 'attachment_urls')
  final List<String> attachmentUrls;
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [
    id, companyId, date, amount, currency, direction, status, mode, reconciliationStatus,
    vendorId, counterpartyName, categoryId, description, referenceNumber, bankAccountId,
    invoiceIds, attachmentUrls
  ];
}
