import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal extends Equatable {
  const Goal({
    required this.id,
    required this.companyId,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    this.icon,
    this.description,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  final String id;
  final String companyId;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final DateTime deadline;
  final String? icon;
  final String? description;

  double get progress => (currentAmount / targetAmount).clamp(0.0, 1.0);
  bool get isCompleted => currentAmount >= targetAmount;
  int get daysRemaining => deadline.difference(DateTime.now()).inDays;
  Map<String, dynamic> toJson() => _$GoalToJson(this);

  @override
  List<Object?> get props => [id, companyId, name, targetAmount, currentAmount, deadline, icon, description];
}
