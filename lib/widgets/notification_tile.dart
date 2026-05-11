/// File: lib/widgets/notification_tile.dart
/// Purpose: List tile for displaying notification title, subtitle, and read status.

import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isRead = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        Icons.notifications,
        color: isRead ? AppColors.grey : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.w400 : FontWeight.w700,
        ),
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
    );
  }
}
