/// File: lib/features/auth/providers/auth_provider.dart
/// Purpose: Manages authentication state and token persistence across app sessions.
/// Features: Login/register, token persistence, session restoration, error handling.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/api_service.dart';
import '../services/auth_service.dart';

/// Provider for API service instance
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

/// Provider for auth service with API service dependency
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.watch(apiServiceProvider)),
);

/// Immutable authentication state class
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final String? token;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.token,
  });

  /// Creates a copy of this state with specified fields replaced
  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    String? token,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
      token: token ?? this.token,
    );
  }
}

/// State notifier for managing authentication logic
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._ref) : super(const AuthState());

  final Ref _ref;
  static const String _tokenKey = 'jwt_token';

  /// Initializes auth state by checking for stored token on app start
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      if (token != null && token.isNotEmpty) {
        _ref.read(apiServiceProvider).setToken(token);
        state = state.copyWith(isAuthenticated: true, token: token);
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to restore session: $e');
    }
  }

  /// Authenticates user with email and password
  /// Returns true on success, false on failure
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (email.isEmpty || password.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'Email and password cannot be empty',
        );
        return false;
      }

      final token = await _ref
          .read(authServiceProvider)
          .login(email: email, password: password);

      await _persist(token);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        token: token,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Registers new user with provided details
  /// Returns true on success, false on failure
  Future<bool> register(
    String name,
    String email,
    String password, {
    String role = 'student',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'All fields are required',
        );
        return false;
      }

      final token = await _ref
          .read(authServiceProvider)
          .register(name: name, email: email, password: password, role: role);

      await _persist(token);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        token: token,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Logs out user and clears session data
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      _ref.read(apiServiceProvider).setToken(null);
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(error: 'Logout failed: $e');
    }
  }

  /// Persists authentication token to local storage
  Future<void> _persist(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      _ref.read(apiServiceProvider).setToken(token);
    } catch (e) {
      state = state.copyWith(error: 'Failed to save session: $e');
    }
  }
}

/// Riverpod state notifier provider for authentication
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref),
);
