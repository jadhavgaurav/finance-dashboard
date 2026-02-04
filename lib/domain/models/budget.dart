import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

enum BudgetPeriod { monthly, weekly, yearly }

@JsonSerializable()
class Budget extends Equatable {
  const Budget({
    required this.id,
    required this.companyId,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.spent,
    required this.period,
    required this.startDate,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  final String id;
  final String companyId;
  final String categoryId;
  final String categoryName;
  final double amount;
  final double spent;
  final BudgetPeriod period;
  final DateTime startDate;

  double get remaining => amount - spent;
  double get progress => (spent / amount).clamp(0.0, 1.0);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  @override
  List<Object?> get props => [id, companyId, categoryId, categoryName, amount, spent, period, startDate];
}
