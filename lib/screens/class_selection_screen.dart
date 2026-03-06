import 'package:flutter/material.dart';
import '../main.dart';

class ClassSelectionScreen extends StatelessWidget {
  final String day;
  final int period;

  const ClassSelectionScreen({super.key, required this.day, required this.period});

  @override
  Widget build(BuildContext context) {
    final List<TimetableInfo> dummyClasses = [
      TimetableInfo(id: '1', name: 'アルゴリズムとデータ構造', room: '101教室'),
      TimetableInfo(id: '2', name: 'データベース工学', room: '102教室'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('$day曜日 $period限の授業を選択')),
      body: ListView.builder(
        itemCount: dummyClasses.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('未選択に戻す', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context, 'REMOVE'),
            );
          }
          final info = dummyClasses[index - 1];
          return ListTile(
            title: Text(info.name),
            subtitle: Text(info.room),
            onTap: () => Navigator.pop(context, info),
          );
        },
      ),
    );
  }
}