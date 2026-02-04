// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  date: DateTime.parse(json['date'] as String),
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  direction: $enumDecode(_$TransactionDirectionEnumMap, json['direction']),
  status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
  mode: $enumDecode(_$PaymentModeEnumMap, json['mode']),
  reconciliationStatus: $enumDecode(
    _$ReconciliationStatusEnumMap,
    json['reconciliation_status'],
  ),
  vendorId: json['vendor_id'] as String?,
  counterpartyName: json['counterparty_name'] as String?,
  categoryId: json['category_id'] as String?,
  description: json['description'] as String?,
  referenceNumber: json['reference_number'] as String?,
  bankAccountId: json['bank_account_id'] as String?,
  invoiceIds:
      (json['invoice_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  attachmentUrls:
      (json['attachment_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'currency': instance.currency,
      'direction': _$TransactionDirectionEnumMap[instance.direction]!,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'mode': _$PaymentModeEnumMap[instance.mode]!,
      'reconciliation_status':
          _$ReconciliationStatusEnumMap[instance.reconciliationStatus]!,
      'vendor_id': instance.vendorId,
      'counterparty_name': instance.counterpartyName,
      'category_id': instance.categoryId,
      'description': instance.description,
      'reference_number': instance.referenceNumber,
      'bank_account_id': instance.bankAccountId,
      'invoice_ids': instance.invoiceIds,
      'attachment_urls': instance.attachmentUrls,
    };

const _$TransactionDirectionEnumMap = {
  TransactionDirection.incoming: 'incoming',
  TransactionDirection.outgoing: 'outgoing',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.draft: 'draft',
  TransactionStatus.pendingApproval: 'pendingApproval',
  TransactionStatus.approved: 'approved',
  TransactionStatus.posted: 'posted',
  TransactionStatus.failed: 'failed',
  TransactionStatus.reversed: 'reversed',
  TransactionStatus.voided: 'voided',
};

const _$PaymentModeEnumMap = {
  PaymentMode.cash: 'cash',
  PaymentMode.cheque: 'cheque',
  PaymentMode.rtgs: 'rtgs',
  PaymentMode.neft: 'neft',
  PaymentMode.imps: 'imps',
  PaymentMode.pfms: 'pfms',
};

const _$ReconciliationStatusEnumMap = {
  ReconciliationStatus.matched: 'matched',
  ReconciliationStatus.unmatched: 'unmatched',
  ReconciliationStatus.suggested: 'suggested',
  ReconciliationStatus.ignored: 'ignored',
};
