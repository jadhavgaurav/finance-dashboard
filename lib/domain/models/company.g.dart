// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  currency: json['currency'] as String,
  fiscalYearStartMonth: (json['fiscalYearStartMonth'] as num).toInt(),
  pan: json['pan'] as String?,
  gstin: json['gstin'] as String?,
);

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'currency': instance.currency,
  'fiscalYearStartMonth': instance.fiscalYearStartMonth,
  'pan': instance.pan,
  'gstin': instance.gstin,
};
