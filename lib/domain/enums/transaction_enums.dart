
enum TransactionStatus {
  draft,
  pendingApproval,
  approved,
  posted,
  failed,
  reversed,
  voided;

  String get label {
    switch (this) {
      case TransactionStatus.draft:
        return 'Draft';
      case TransactionStatus.pendingApproval:
        return 'Pending Approval';
      case TransactionStatus.approved:
        return 'Approved';
      case TransactionStatus.posted:
        return 'Posted';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.reversed:
        return 'Reversed';
      case TransactionStatus.voided:
        return 'Void';
    }
  }
}

enum ReconciliationStatus {
  matched,
  unmatched,
  suggested,
  ignored;

  String get label {
    switch (this) {
      case ReconciliationStatus.matched:
        return 'Matched';
      case ReconciliationStatus.unmatched:
        return 'Unmatched';
      case ReconciliationStatus.suggested:
        return 'Suggested';
      case ReconciliationStatus.ignored:
        return 'Ignored';
    }
  }
}

enum PaymentMode {
  cash,
  cheque,
  rtgs,
  neft,
  imps,
  pfms;

  String get label {
    switch (this) {
      case PaymentMode.cash:
        return 'Cash';
      case PaymentMode.cheque:
        return 'Cheque';
      case PaymentMode.rtgs:
        return 'RTGS';
      case PaymentMode.neft:
        return 'NEFT';
      case PaymentMode.imps:
        return 'IMPS';
      case PaymentMode.pfms:
        return 'PFMS';
    }
  }
}

enum TransactionDirection {
  incoming,
  outgoing;
  
  String get label => this == incoming ? 'Cash In' : 'Cash Out';
}
