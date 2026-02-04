import 'package:agency_finance/domain/models/bank_account.dart';
import 'package:agency_finance/domain/models/company.dart';
import 'package:agency_finance/domain/models/vendor.dart';

abstract class CompanyRepository {
  Future<List<Company>> getCompanies();
  Future<Company?> getCompany(String id);
  Future<void> createCompany(Company company);
  Future<bool> hasCompany();
  
  Future<List<BankAccount>> getBankAccounts(String companyId);
  Future<List<Vendor>> getVendors(String companyId);
}
