import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/core/routing/app_router.dart';
import 'package:agency_finance/core/routing/app_routes.dart';
import 'package:agency_finance/domain/models/company.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingController extends StateNotifier<bool> {
  OnboardingController(this.ref) : super(false);

  final Ref ref;

  Future<void> completeOnboarding({
    required String companyName,
    required String currency,
    required String fiscalYearStart,
  }) async {
    state = true;
    try {
      // Create company
      final company = Company(
        id: 'c1', // Mock ID
        name: companyName,
        currency: currency,
        fiscalYearStartMonth: int.tryParse(fiscalYearStart) ?? 4,
        address: '123 Business St', // Default
      );
      
      await ref.read(companyRepositoryProvider).createCompany(company);
      
      // Navigate to Home
      ref.read(goRouterProvider).go(AppRoutes.home);
    } catch (e) {
      // Handle error
    } finally {
      state = false;
    }
  }
}

final onboardingControllerProvider = StateNotifierProvider<OnboardingController, bool>((ref) {
  return OnboardingController(ref);
});
