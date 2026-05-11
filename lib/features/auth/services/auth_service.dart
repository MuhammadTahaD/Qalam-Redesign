/// File: lib/features/auth/services/auth_service.dart
/// Purpose: Handles login and registration API calls.

import '../../../core/services/api_service.dart';

class AuthService {
  final ApiService api;

  AuthService(this.api);

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final result =
        await api.post(
              '/auth/login',
              body: {'email': email, 'password': password},
            )
            as Map<String, dynamic>;
    return (result['token'] ?? '').toString();
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
    String role = 'student',
  }) async {
    final result =
        await api.post(
              '/auth/register',
              body: {
                'name': name,
                'email': email,
                'password': password,
                'role': role,
              },
            )
            as Map<String, dynamic>;
    return (result['token'] ?? '').toString();
  }
}
