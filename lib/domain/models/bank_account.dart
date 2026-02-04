import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_account.g.dart';

@JsonSerializable()
class BankAccount extends Equatable {
  const BankAccount({
    required this.id,
    required this.companyId,
    required this.bankName,
    required this.accountNumberLast4,
    required this.ifscCode,
    required this.accountType,
    required this.openingBalance,
    required this.openingDate,
    required this.currentBalance,
    required this.lastSyncedAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => _$BankAccountFromJson(json);

  final String id;
  final String companyId;
  final String bankName;
  @JsonKey(name: 'account_number_last_4')
  final String accountNumberLast4;
  @JsonKey(name: 'ifsc_code')
  final String ifscCode;
  @JsonKey(name: 'account_type')
  final String accountType; // Savings, Current
  @JsonKey(name: 'opening_balance')
  final double openingBalance;
  @JsonKey(name: 'opening_date')
  final DateTime openingDate;
  @JsonKey(name: 'current_balance')
  final double currentBalance;
  @JsonKey(name: 'last_synced_at')
  final DateTime? lastSyncedAt;
  Map<String, dynamic> toJson() => _$BankAccountToJson(this);

  @override
  List<Object?> get props => [
    id, companyId, bankName, accountNumberLast4, ifscCode, accountType, 
    openingBalance, openingDate, currentBalance, lastSyncedAt
  ];
}
