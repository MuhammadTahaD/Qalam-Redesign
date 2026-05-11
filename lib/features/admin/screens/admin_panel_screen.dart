/// File: lib/features/admin/screens/admin_panel_screen.dart
/// Purpose: Admin interface for managing student results.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/admin_service.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  late Future<List<AdminResultItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(adminServiceProvider).fetchResults();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = ref.read(adminServiceProvider).fetchResults();
    });
    await _future;
  }

  Future<void> _editMarks(AdminResultItem item) async {
    final gradeController = TextEditingController(text: item.grade);
    final gpaController = TextEditingController(text: item.gpa.toString());

    final save = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student Marks'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.studentName),
              const SizedBox(height: 8),
              Text(item.courseName),
              const SizedBox(height: 16),
              TextField(
                controller: gradeController,
                decoration: const InputDecoration(labelText: 'Grade'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: gpaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'GPA'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (save != true) {
      return;
    }

    final gpa = double.tryParse(gpaController.text.trim());
    if (gpa == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid GPA value')));
      return;
    }

    try {
      await ref
          .read(adminServiceProvider)
          .updateMarks(
            id: item.id,
            grade: gradeController.text.trim(),
            gpa: gpa,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Marks updated successfully')),
      );
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instructor Admin Panel')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<AdminResultItem>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Failed to load results: ${snapshot.error}'),
                  ),
                ],
              );
            }

            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const Center(child: Text('No student results found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text('${item.studentName} - ${item.courseName}'),
                    subtitle: Text('Grade: ${item.grade} | GPA: ${item.gpa}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editMarks(item),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
