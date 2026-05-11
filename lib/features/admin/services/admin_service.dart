/// File: lib/features/admin/services/admin_service.dart
/// Purpose: Service providing admin functionality for viewing and updating student results.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/api_service.dart';
import '../../auth/providers/auth_provider.dart';

class AdminResultItem {
  final String id;
  final String studentName;
  final String courseName;
  final String grade;
  final double gpa;

  const AdminResultItem({
    required this.id,
    required this.studentName,
    required this.courseName,
    required this.grade,
    required this.gpa,
  });

  factory AdminResultItem.fromJson(Map<String, dynamic> json) {
    final student = json['studentId'] as Map<String, dynamic>?;
    final course = json['courseId'] as Map<String, dynamic>?;

    return AdminResultItem(
      id: (json['_id'] ?? '').toString(),
      studentName: (student?['name'] ?? 'Unknown Student').toString(),
      courseName: (course?['name'] ?? 'Unknown Course').toString(),
      grade: (json['grade'] ?? '').toString(),
      gpa: (json['gpa'] as num? ?? 0).toDouble(),
    );
  }
}

class AdminService {
  final ApiService api;

  AdminService(this.api);

  Future<List<AdminResultItem>> fetchResults() async {
    final res = await api.get('/admin/results') as Map<String, dynamic>;
    final list = (res['data'] as List<dynamic>? ?? []);
    return list
        .map((e) => AdminResultItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateMarks({
    required String id,
    required String grade,
    required double gpa,
  }) async {
    await api.put('/admin/results/$id', body: {'grade': grade, 'gpa': gpa});
  }
}

final adminServiceProvider = Provider<AdminService>(
  (ref) => AdminService(ref.watch(apiServiceProvider)),
);
