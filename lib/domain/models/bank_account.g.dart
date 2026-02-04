// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  bankName: json['bankName'] as String,
  accountNumberLast4: json['account_number_last_4'] as String,
  ifscCode: json['ifsc_code'] as String,
  accountType: json['account_type'] as String,
  openingBalance: (json['opening_balance'] as num).toDouble(),
  openingDate: DateTime.parse(json['opening_date'] as String),
  currentBalance: (json['current_balance'] as num).toDouble(),
  lastSyncedAt: json['last_synced_at'] == null
      ? null
      : DateTime.parse(json['last_synced_at'] as String),
);

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'bankName': instance.bankName,
      'account_number_last_4': instance.accountNumberLast4,
      'ifsc_code': instance.ifscCode,
      'account_type': instance.accountType,
      'opening_balance': instance.openingBalance,
      'opening_date': instance.openingDate.toIso8601String(),
      'current_balance': instance.currentBalance,
      'last_synced_at': instance.lastSyncedAt?.toIso8601String(),
    };
