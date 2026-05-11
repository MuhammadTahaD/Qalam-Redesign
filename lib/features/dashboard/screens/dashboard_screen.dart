/// File: lib/features/dashboard/screens/dashboard_screen.dart
/// Purpose: Main dashboard showing courses, attendance, results, and recent notifications.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/attendance_provider.dart';
import '../../../core/providers/courses_provider.dart';
import '../../../core/providers/results_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../screens/attendance/attendance_screen.dart';
import '../../../screens/results/results_screen.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/course_tile.dart';
import '../../../widgets/gpa_card.dart';
import '../../../widgets/notification_tile.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../profile/screens/profile_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(notificationProvider.notifier).load(refresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _DashboardHome(
        onViewAllNotifications: () =>
            Navigator.pushNamed(context, '/notifications'),
      ),
      const AttendanceScreen(),
      const ResultsScreen(),
      const ProfileScreen(),
    ];

    final user = ref.watch(userProvider).valueOrNull;
    final isInstructor = user?.isInstructor ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Portal')),
      drawer: _AppDrawer(
        isInstructor: isInstructor,
        onOpen: (route) {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        },
      ),
      body: SafeArea(child: tabs[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Results',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final void Function(String route) onOpen;
  final bool isInstructor;

  const _AppDrawer({required this.onOpen, required this.isInstructor});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.secondary),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Navigate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Assignments'),
            onTap: () => onOpen('/assignments'),
          ),
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: const Text('Quizzes'),
            onTap: () => onOpen('/quizzes'),
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('Gradebook'),
            onTap: () => onOpen('/gradebook'),
          ),
          ListTile(
            leading: const Icon(Icons.fact_check_outlined),
            title: const Text('Attendance'),
            onTap: () => onOpen('/attendance'),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_outlined),
            title: const Text('Results'),
            onTap: () => onOpen('/results'),
          ),
          if (isInstructor)
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text('Instructor Panel'),
              onTap: () => onOpen('/admin-panel'),
            ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            onTap: () => onOpen('/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () => onOpen('/profile'),
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends ConsumerWidget {
  final VoidCallback onViewAllNotifications;

  const _DashboardHome({required this.onViewAllNotifications});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final attendanceAsync = ref.watch(attendanceProvider);
    final resultsAsync = ref.watch(resultsProvider);
    final coursesAsync = ref.watch(coursesProvider);
    final notificationState = ref.watch(notificationProvider);

    final cgpa = resultsAsync.maybeWhen(
      data: (items) => items.isEmpty
          ? 0.0
          : items.map((e) => e.gpa).reduce((a, b) => a + b) / items.length,
      orElse: () => 0.0,
    );

    final attendance = attendanceAsync.maybeWhen(
      data: (items) => items.isEmpty
          ? 0.0
          : items.map((e) => e.percentage).reduce((a, b) => a + b) /
                items.length,
      orElse: () => 0.0,
    );

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userProvider);
        ref.invalidate(attendanceProvider);
        ref.invalidate(resultsProvider);
        ref.invalidate(coursesProvider);
        await ref.read(notificationProvider.notifier).load(refresh: true);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          userAsync.when(
            data: (user) => Text(
              'Hi, ${user.name}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            loading: () => const Text(
              'Hi, Student',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            error: (_, _) => const Text(
              'Hi, Student',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search courses, results, notifications...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GpaCard(title: 'CGPA', value: cgpa),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Attendance %',
                        style: TextStyle(color: AppColors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        attendance.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Ongoing Courses',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          coursesAsync.when(
            data: (courses) {
              if (courses.isEmpty) {
                return const Text('No active courses');
              }
              return Column(
                children: courses
                    .take(3)
                    .map(
                      (course) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: CourseTile(
                          course: course.name,
                          instructor: course.instructor,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => Text('Failed to load courses: $e'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Recent Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  if (notificationState.unreadCount > 0)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '${notificationState.unreadCount}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              TextButton(
                onPressed: onViewAllNotifications,
                child: const Text('View all'),
              ),
            ],
          ),
          if (notificationState.loading)
            const Center(child: CircularProgressIndicator())
          else if (notificationState.items.isEmpty)
            const Text('No new notifications')
          else
            ...notificationState.items
                .take(3)
                .map(
                  (n) => NotificationTile(
                    title: n.title,
                    subtitle: n.message,
                    isRead: n.isRead,
                  ),
                ),
        ],
      ),
    );
  }
}
