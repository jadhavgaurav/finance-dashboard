import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/core/routing/app_routes.dart';
import 'package:agency_finance/features/approvals/presentation/screens/approvals_screen.dart';
import 'package:agency_finance/features/auth/presentation/screens/login_screen.dart';
import 'package:agency_finance/features/budget/presentation/screens/budget_screen.dart';
import 'package:agency_finance/features/goals/presentation/screens/goals_screen.dart';
import 'package:agency_finance/features/home/presentation/screens/home_screen.dart';
import 'package:agency_finance/features/home/presentation/screens/main_shell_screen.dart';
import 'package:agency_finance/features/home/presentation/screens/notifications_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/more_screen.dart';
import 'package:agency_finance/features/more/presentation/screens/secondary_screens.dart';
import 'package:agency_finance/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:agency_finance/features/reports/presentation/screens/reports_screen.dart';
import 'package:agency_finance/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  
  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepo.currentAuthStatus;
      
      if (isLoggedIn == null) {
        return null;
      }

      
      final isLoggingIn = state.uri.toString() == AppRoutes.login;
      final isOnboarding = state.uri.toString() == AppRoutes.onboarding;

      if (!isLoggedIn) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      // Sync company check if possible, or just default to home for now
      // MockCompanyRepo could also have a currentCompany getter or similar
      
      if (isLoggingIn || isOnboarding) return AppRoutes.home;

      return null;
    },
    refreshListenable: _StreamRouterRefresh(authRepo.authStateChanges),
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.transactions,
                builder: (context, state) => const TransactionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.approvals,
                builder: (context, state) => const ApprovalsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reports,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.more,
                builder: (context, state) => const MoreScreen(),
                routes: [
                  GoRoute(path: 'companies', builder: (context, state) => const CompaniesScreen()),
                  GoRoute(path: 'bank-accounts', builder: (context, state) => const BankAccountsScreen()),
                  GoRoute(path: 'vendors', builder: (context, state) => const VendorsScreen()),
                  GoRoute(path: 'invoices', builder: (context, state) => const InvoicesListScreen()),
                  GoRoute(path: 'settings', builder: (context, state) => const SettingsScreen()),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.budgets,
        builder: (context, state) => const BudgetScreen(),
      ),
      GoRoute(
        path: AppRoutes.goals,
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
});

class _StreamRouterRefresh extends ChangeNotifier {
  _StreamRouterRefresh(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
