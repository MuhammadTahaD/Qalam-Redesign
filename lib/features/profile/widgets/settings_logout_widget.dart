// File: lib/features/profile/widgets/settings_logout_widget.dart
// Purpose: Dev profile switch, preferences, and logout section.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/primary_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class SettingsAndLogoutWidget extends ConsumerStatefulWidget {
  const SettingsAndLogoutWidget({super.key});

  @override
  ConsumerState<SettingsAndLogoutWidget> createState() =>
      _SettingsAndLogoutWidgetState();
}

class _SettingsAndLogoutWidgetState
    extends ConsumerState<SettingsAndLogoutWidget> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedProfileIndexProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dev Mode - Profile Switch',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('UG')),
                ButtonSegment(value: 1, label: Text('PG')),
                ButtonSegment(value: 2, label: Text('PhD')),
              ],
              selected: {selected},
              onSelectionChanged: (s) =>
                  ref.read(selectedProfileIndexProvider.notifier).state =
                      s.first,
            ),
            const Divider(height: 24),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Notification Preferences'),
              value: notificationsEnabled,
              onChanged: (v) => setState(() => notificationsEnabled = v),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Language'),
              trailing: const Text('English ?'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language options coming soon')),
              ),
            ),
            const Divider(height: 24),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: PrimaryButton(
                text: 'Logout',
                onPressed: () => ref.read(authProvider.notifier).logout(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
