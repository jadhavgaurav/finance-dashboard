import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/domain/models/notification.dart';
import 'package:agency_finance/features/home/presentation/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationControllerProvider);

    return Scaffold(
      appBar: FinanceAppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => ref.read(notificationControllerProvider.notifier).markAllAsRead(),
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: state.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications yet'));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _NotificationTile(notification: notification);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});
  final AppNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        if (!notification.isRead) {
          ref.read(notificationControllerProvider.notifier).markAsRead(notification.id);
        }
      },
      leading: CircleAvatar(
        backgroundColor: _getTypeColor(context, notification.type).withValues(alpha: 0.1),
        child: Icon(_getTypeIcon(notification.type), color: _getTypeColor(context, notification.type), size: 18),
      ),
      title: Text(
        notification.title,
        style: context.typography.body.copyWith(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.message, style: context.typography.bodySmall),
          const Gap(4),
          Text(
            _formatTimestamp(notification.timestamp),
            style: context.typography.caption.copyWith(color: context.colors.textTertiary),
          ),
        ],
      ),
      trailing: !notification.isRead
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: context.colors.accent, shape: BoxShape.circle),
            )
          : null,
    );
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.warning: return Icons.warning_amber_rounded;
      case NotificationType.success: return Icons.check_circle_outline;
      case NotificationType.error: return Icons.error_outline;
      case NotificationType.approval: return Icons.rule;
      default: return Icons.info_outline;
    }
  }

  Color _getTypeColor(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.warning: return Colors.orange;
      case NotificationType.success: return context.colors.success;
      case NotificationType.error: return context.colors.error;
      case NotificationType.approval: return context.colors.accent;
      default: return context.colors.textSecondary;
    }
  }

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
