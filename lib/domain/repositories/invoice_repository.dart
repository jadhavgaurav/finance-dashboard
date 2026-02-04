import 'package:agency_finance/domain/models/invoice.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getInvoices(String companyId);
  Future<Invoice?> getInvoice(String id);
  Future<void> createInvoice(Invoice invoice);
}
