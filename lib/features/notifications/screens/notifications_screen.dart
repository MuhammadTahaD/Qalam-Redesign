/// File: lib/features/notifications/screens/notifications_screen.dart
/// Purpose: Screen displaying paginated list of user notifications.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/notification_tile.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(notificationProvider.notifier).load(refresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(notificationProvider.notifier).load(refresh: true),
        child: state.loading
            ? const Center(child: CircularProgressIndicator())
            : state.items.isEmpty
            ? const Center(child: Text('No notifications yet'))
            : ListView.builder(
                itemCount: state.items.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    if (state.loadingMore) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state.hasMore) {
                      return TextButton(
                        onPressed: () =>
                            ref.read(notificationProvider.notifier).load(),
                        child: const Text('Load more'),
                      );
                    }
                    return const SizedBox.shrink();
                  }

                  final item = state.items[index];
                  return NotificationTile(
                    title: item.title,
                    subtitle: item.message,
                    isRead: item.isRead,
                    onTap: () async {
                      if (!item.isRead) {
                        await ref
                            .read(notificationProvider.notifier)
                            .markRead(item.id);
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
