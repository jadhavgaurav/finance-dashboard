// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
  status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
  category: json['category'] as String?,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'amount': instance.amount,
      'currency': instance.currency,
      'nextBillingDate': instance.nextBillingDate.toIso8601String(),
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'category': instance.category,
      'icon': instance.icon,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.cancelled: 'cancelled',
  SubscriptionStatus.expired: 'expired',
  SubscriptionStatus.trial: 'trial',
};
