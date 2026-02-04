import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  const Company({
    required this.id,
    required this.name,
    required this.address,
    required this.currency,
    required this.fiscalYearStartMonth,
    this.pan,
    this.gstin,
  });

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  final String id;
  final String name;
  final String address;
  final String currency;
  final int fiscalYearStartMonth; // 1 = January, 4 = April
  final String? pan;
  final String? gstin;
  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object?> get props => [id, name, address, currency, fiscalYearStartMonth, pan, gstin];
}
