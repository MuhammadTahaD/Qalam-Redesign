/// File: lib/core/providers/results_provider.dart
/// Purpose: Riverpod provider for fetching academic results.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../models/result_model.dart';

final resultsProvider = FutureProvider<List<ResultModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final result = await api.get('/results') as Map<String, dynamic>;
  final list = (result['data'] as List<dynamic>? ?? []);
  return list
      .map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
      .toList();
});
