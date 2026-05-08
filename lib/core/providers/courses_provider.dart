import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../models/course_model.dart';

final coursesProvider = FutureProvider<List<CourseModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final result = await api.get('/courses') as Map<String, dynamic>;
  final list = (result['data'] as List<dynamic>? ?? []);
  return list
      .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
      .toList();
});
