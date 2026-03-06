import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/timetable_screen.dart';
import 'screens/settings_screen.dart';
import 'models/faculty.dart';

// 授業データの型
class TimetableInfo {
  final String id;
  final String name;
  final String room;

  TimetableInfo({required this.id, required this.name, required this.room});
}

// 状態の定義
class TimetableState {
  final int year;
  final String semester;
  final int maxPeriods;
  final FacultyType faculty;
  final Map<String, TimetableInfo> classes; // 修正ポイント: 追加

  TimetableState({
    required this.year,
    required this.semester,
    required this.maxPeriods,
    required this.faculty,
    this.classes = const {},
  });

  TimetableState copyWith({
    int? year,
    String? semester,
    int? maxPeriods,
    FacultyType? faculty,
    Map<String, TimetableInfo>? classes,
  }) {
    return TimetableState(
      year: year ?? this.year,
      semester: semester ?? this.semester,
      maxPeriods: maxPeriods ?? this.maxPeriods,
      faculty: faculty ?? this.faculty,
      classes: classes ?? this.classes,
    );
  }
}

// 操作ロジック
class TimetableNotifier extends StateNotifier<TimetableState> {
  TimetableNotifier() : super(TimetableState(
    year: 2024, 
    semester: '春', 
    maxPeriods: 5,
    faculty: FacultyType.informationScience,
  ));

  void incrementYear() => state = state.copyWith(year: state.year + 1);
  void decrementYear() => state = state.copyWith(year: state.year - 1);
  void toggleSemester() => state = state.copyWith(semester: state.semester == '春' ? '秋' : '春');
  void updateFaculty(FacultyType newFaculty) => state = state.copyWith(faculty: newFaculty);
  
  void setClass(String day, int period, TimetableInfo info) {
    final newClasses = Map<String, TimetableInfo>.from(state.classes);
    newClasses['$day-$period'] = info;
    state = state.copyWith(classes: newClasses);
  }

  void removeClass(String day, int period) {
    final newClasses = Map<String, TimetableInfo>.from(state.classes);
    newClasses.remove('$day-$period');
    state = state.copyWith(classes: newClasses);
  }
}

final timetableProvider = StateNotifierProvider<TimetableNotifier, TimetableState>((ref) => TimetableNotifier());
final navigationIndexProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Schedule',
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navigationIndexProvider);
    final screens = [const TimetableScreen(), const SettingsScreen()];

    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (val) => ref.read(navigationIndexProvider.notifier).state = val,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '時間割'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
    );
  }
}