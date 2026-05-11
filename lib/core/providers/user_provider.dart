/// File: lib/core/providers/user_provider.dart
/// Purpose: Riverpod provider for fetching user profile data.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../models/user_model.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final result = await api.get('/user/profile') as Map<String, dynamic>;
  return UserModel.fromJson(result['data'] as Map<String, dynamic>);
});
