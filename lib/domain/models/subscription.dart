import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

enum SubscriptionStatus { active, cancelled, expired, trial }

@JsonSerializable()
class Subscription extends Equatable {
  const Subscription({
    required this.id,
    required this.companyId,
    required this.name,
    required this.amount,
    required this.currency,
    required this.nextBillingDate,
    required this.status,
    this.category,
    this.icon,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  final String id;
  final String companyId;
  final String name;
  final double amount;
  final String currency;
  final DateTime nextBillingDate;
  final SubscriptionStatus status;
  final String? category;
  final String? icon;
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  List<Object?> get props => [id, companyId, name, amount, currency, nextBillingDate, status, category, icon];
}
