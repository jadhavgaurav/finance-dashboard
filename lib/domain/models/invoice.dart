import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

enum InvoiceStatus {
  unpaid,
  partiallyPaid,
  paid,
  overdue,
  voided
}

@JsonSerializable()
class Invoice extends Equatable {
  const Invoice({
    required this.id,
    required this.companyId,
    required this.vendorId,
    required this.invoiceNumber,
    required this.amount,
    required this.currency,
    required this.invoiceDate,
    required this.dueDate,
    required this.status,
    this.paidAmount = 0,
    this.attachmentUrl,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  final String id;
  final String companyId;
  final String vendorId;
  @JsonKey(name: 'invoice_number')
  final String invoiceNumber;
  final double amount;
  final String currency;
  @JsonKey(name: 'invoice_date')
  final DateTime invoiceDate;
  @JsonKey(name: 'due_date')
  final DateTime dueDate;
  final InvoiceStatus status;
  @JsonKey(name: 'paid_amount')
  final double paidAmount;
  @JsonKey(name: 'attachment_url')
  final String? attachmentUrl;
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @override
  List<Object?> get props => [
    id, companyId, vendorId, invoiceNumber, amount, currency, 
    invoiceDate, dueDate, status, paidAmount, attachmentUrl
  ];
}
