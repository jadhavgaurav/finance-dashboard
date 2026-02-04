import 'package:agency_finance/domain/models/subscription.dart';

abstract class SubscriptionRepository {
  Future<List<Subscription>> getSubscriptions(String companyId);
  Future<void> createSubscription(Subscription subscription);
  Future<void> updateSubscription(Subscription subscription);
  Future<void> deleteSubscription(String subscriptionId);
}
