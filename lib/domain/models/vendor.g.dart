// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
  id: json['id'] as String,
  companyId: json['companyId'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  taxId: json['tax_id'] as String?,
  bankName: json['bank_name'] as String?,
  bankAccountNo: json['bank_account_no'] as String?,
  ifscCode: json['ifsc_code'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
);

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
  'id': instance.id,
  'companyId': instance.companyId,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'tax_id': instance.taxId,
  'bank_name': instance.bankName,
  'bank_account_no': instance.bankAccountNo,
  'ifsc_code': instance.ifscCode,
  'is_verified': instance.isVerified,
};
