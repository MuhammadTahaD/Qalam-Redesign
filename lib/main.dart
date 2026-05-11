import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/academics/screens/assignments_screen.dart';
import 'features/academics/screens/gradebook_screen.dart';
import 'features/academics/screens/quizzes_screen.dart';
import 'features/admin/screens/admin_panel_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/notifications/screens/notifications_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'screens/attendance/attendance_screen.dart';
import 'screens/results/results_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authProvider.notifier).initialize());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/notifications': (_) => const NotificationsScreen(),
        '/assignments': (_) => const AssignmentsScreen(),
        '/quizzes': (_) => const QuizzesScreen(),
        '/gradebook': (_) => const GradebookScreen(),
        '/attendance': (_) => const AttendanceScreen(),
        '/results': (_) => const ResultsScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/admin-panel': (_) => const AdminPanelScreen(),
      },
      home: const ProfileScreen(),
    );
  }
}
