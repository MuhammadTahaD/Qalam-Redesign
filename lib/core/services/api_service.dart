/// File: lib/core/services/api_service.dart
/// Purpose: HTTP client service handling API requests with JWT token management.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiService {
  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      if (_token != null && _token!.isNotEmpty)
        'Authorization': 'Bearer $_token',
    };
  }

  Future<dynamic> get(String path) async {
    return _handle(
      () =>
          http.get(Uri.parse('${AppConfig.baseUrl}$path'), headers: _headers()),
    );
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    return _handle(
      () => http.post(
        Uri.parse('${AppConfig.baseUrl}$path'),
        headers: _headers(),
        body: jsonEncode(body ?? {}),
      ),
    );
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    return _handle(
      () => http.put(
        Uri.parse('${AppConfig.baseUrl}$path'),
        headers: _headers(),
        body: jsonEncode(body ?? {}),
      ),
    );
  }

  Future<dynamic> delete(String path) async {
    return _handle(
      () => http.delete(
        Uri.parse('${AppConfig.baseUrl}$path'),
        headers: _headers(),
      ),
    );
  }

  Future<dynamic> _handle(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(const Duration(seconds: 15));
      final data = response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      }

      final message = data is Map<String, dynamic>
          ? (data['message'] ?? 'Request failed').toString()
          : 'Request failed';
      throw Exception(message);
    } on TimeoutException {
      throw Exception('Request timeout. Please check your backend/server.');
    } on http.ClientException {
      throw Exception(
        'Cannot reach API at ${AppConfig.baseUrl}. Ensure backend and MongoDB are running.',
      );
    } on FormatException {
      throw Exception('Invalid server response format.');
    }
  }
}
