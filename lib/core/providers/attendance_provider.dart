/// File: lib/core/providers/attendance_provider.dart
/// Purpose: Riverpod provider for fetching attendance data.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../models/attendance_model.dart';

final attendanceProvider = FutureProvider<List<AttendanceModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final result = await api.get('/attendance') as Map<String, dynamic>;
  final list = (result['data'] as List<dynamic>? ?? []);
  return list
      .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
      .toList();
});
