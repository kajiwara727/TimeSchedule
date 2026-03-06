import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../models/faculty.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timetableProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('学部・研究科'),
            subtitle: Text(state.faculty.displayName),
            onTap: () => _showFacultyPicker(context, ref),
          ),
          const Divider(),
          ListTile(
            title: const Text('表示年度'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.remove), onPressed: () => ref.read(timetableProvider.notifier).decrementYear()),
                Text('${state.year}'),
                IconButton(icon: const Icon(Icons.add), onPressed: () => ref.read(timetableProvider.notifier).incrementYear()),
              ],
            ),
          ),
          ListTile(
            title: const Text('セメスター'),
            trailing: TextButton(
              onPressed: () => ref.read(timetableProvider.notifier).toggleSemester(),
              child: Text(state.semester),
            ),
          ),
        ],
      ),
    );
  }

  void _showFacultyPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: FacultyType.values.length,
        itemBuilder: (context, index) {
          final f = FacultyType.values[index];
          return ListTile(
            title: Text(f.displayName),
            onTap: () {
              ref.read(timetableProvider.notifier).updateFaculty(f);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}