import 'dart:async';

import 'package:agency_finance/core/providers.dart';
import 'package:agency_finance/domain/models/notification.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationController extends AsyncNotifier<List<AppNotification>> {
  @override
  FutureOr<List<AppNotification>> build() async {
    return _fetchNotifications();
  }

  Future<List<AppNotification>> _fetchNotifications() async {
    return ref.read(notificationRepositoryProvider).getNotifications();
  }

  Future<void> markAsRead(String id) async {
    await ref.read(notificationRepositoryProvider).markAsRead(id);
    ref.invalidateSelf();
  }

  Future<void> markAllAsRead() async {
    await ref.read(notificationRepositoryProvider).markAllAsRead();
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchNotifications);
  }
}

final notificationControllerProvider = AsyncNotifierProvider<NotificationController, List<AppNotification>>(NotificationController.new);
