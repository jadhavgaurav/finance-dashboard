import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable()
class Vendor extends Equatable {
  const Vendor({
    required this.id,
    required this.companyId,
    required this.name,
    this.email,
    this.phone,
    this.taxId,
    this.bankName,
    this.bankAccountNo,
    this.ifscCode,
    this.isVerified = false,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  final String id;
  final String companyId;
  final String name;
  final String? email;
  final String? phone;
  @JsonKey(name: 'tax_id')
  final String? taxId;
  @JsonKey(name: 'bank_name')
  final String? bankName;
  @JsonKey(name: 'bank_account_no')
  final String? bankAccountNo;
  @JsonKey(name: 'ifsc_code')
  final String? ifscCode;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  Map<String, dynamic> toJson() => _$VendorToJson(this);

  @override
  List<Object?> get props => [id, companyId, name, email, phone, taxId, bankName, bankAccountNo, ifscCode, isVerified];
}
