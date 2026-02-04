// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  vendorId: json['vendorId'] as String,
  invoiceNumber: json['invoice_number'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  invoiceDate: DateTime.parse(json['invoice_date'] as String),
  dueDate: DateTime.parse(json['due_date'] as String),
  status: $enumDecode(_$InvoiceStatusEnumMap, json['status']),
  paidAmount: (json['paid_amount'] as num?)?.toDouble() ?? 0,
  attachmentUrl: json['attachment_url'] as String?,
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'companyId': instance.companyId,
  'vendorId': instance.vendorId,
  'invoice_number': instance.invoiceNumber,
  'amount': instance.amount,
  'currency': instance.currency,
  'invoice_date': instance.invoiceDate.toIso8601String(),
  'due_date': instance.dueDate.toIso8601String(),
  'status': _$InvoiceStatusEnumMap[instance.status]!,
  'paid_amount': instance.paidAmount,
  'attachment_url': instance.attachmentUrl,
};

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.unpaid: 'unpaid',
  InvoiceStatus.partiallyPaid: 'partiallyPaid',
  InvoiceStatus.paid: 'paid',
  InvoiceStatus.overdue: 'overdue',
  InvoiceStatus.voided: 'voided',
};
