/// File: lib/features/notifications/providers/notification_provider.dart
/// Purpose: Riverpod provider managing notifications with pagination and read status.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/notification_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.watch(apiServiceProvider));
});

class NotificationState {
  final bool loading;
  final bool loadingMore;
  final String? error;
  final List<NotificationModel> items;
  final int page;
  final bool hasMore;

  const NotificationState({
    this.loading = false,
    this.loadingMore = false,
    this.error,
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
  });

  NotificationState copyWith({
    bool? loading,
    bool? loadingMore,
    String? error,
    List<NotificationModel>? items,
    int? page,
    bool? hasMore,
  }) {
    return NotificationState(
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  int get unreadCount => items.where((n) => !n.isRead).length;
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier(this.ref) : super(const NotificationState());

  final Ref ref;

  Future<void> load({bool refresh = false}) async {
    final nextPage = refresh ? 1 : state.page;
    state = state.copyWith(
      loading: nextPage == 1,
      loadingMore: nextPage > 1,
      error: null,
    );

    try {
      final data = await ref
          .read(notificationServiceProvider)
          .fetch(page: nextPage);
      final list = (data['data'] as List<dynamic>? ?? [])
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final merged = nextPage == 1 ? list : [...state.items, ...list];
      state = state.copyWith(
        loading: false,
        loadingMore: false,
        items: merged,
        page: nextPage + 1,
        hasMore: list.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        loadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markRead(String id) async {
    await ref.read(notificationServiceProvider).markAsRead(id);
    final updated = state.items
        .map(
          (n) => n.id == id
              ? NotificationModel(
                  id: n.id,
                  title: n.title,
                  message: n.message,
                  isRead: true,
                  createdAt: n.createdAt,
                )
              : n,
        )
        .toList();
    state = state.copyWith(items: updated);
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
      return NotificationNotifier(ref);
    });
