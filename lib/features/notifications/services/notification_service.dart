import '../../../core/services/api_service.dart';

class NotificationService {
  final ApiService api;

  NotificationService(this.api);

  Future<Map<String, dynamic>> fetch({int page = 1, int limit = 20}) async {
    return await api.get('/notifications?page=$page&limit=$limit')
        as Map<String, dynamic>;
  }

  Future<void> markAsRead(String id) async {
    await api.put('/notifications/$id/read');
  }
}
