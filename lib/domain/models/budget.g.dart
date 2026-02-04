// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  categoryId: json['categoryId'] as String,
  categoryName: json['categoryName'] as String,
  amount: (json['amount'] as num).toDouble(),
  spent: (json['spent'] as num).toDouble(),
  period: $enumDecode(_$BudgetPeriodEnumMap, json['period']),
  startDate: DateTime.parse(json['startDate'] as String),
);

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
  'id': instance.id,
  'companyId': instance.companyId,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'amount': instance.amount,
  'spent': instance.spent,
  'period': _$BudgetPeriodEnumMap[instance.period]!,
  'startDate': instance.startDate.toIso8601String(),
};

const _$BudgetPeriodEnumMap = {
  BudgetPeriod.monthly: 'monthly',
  BudgetPeriod.weekly: 'weekly',
  BudgetPeriod.yearly: 'yearly',
};
