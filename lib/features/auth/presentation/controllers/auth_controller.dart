import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // Listen to repo changes to keep state in sync if needed, 
    // but mainly we rely on the router listening to the repo.
    // However, we can expose the current user state or just void for actions.
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).login(email, password));
    // Navigation is handled by router listening to stream
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(AuthController.new);
