import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import 'class_selection_screen.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});
  final List<String> weekDays = const ['月', '火', '水', '木', '金'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetableState = ref.watch(timetableProvider);

    return Scaffold(
      appBar: AppBar(title: Text('${timetableState.year}年度 ${timetableState.semester}セメスター')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double cellHeight = (constraints.maxHeight - 88) / timetableState.maxPeriods;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: const {0: FixedColumnWidth(40.0)},
                children: [
                  _buildHeaderRow(),
                  ..._buildDataRows(timetableState, cellHeight),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.blue.shade50),
      children: [
        const SizedBox(height: 40),
        ...weekDays.map((day) => Center(child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)))),
      ],
    );
  }

  List<TableRow> _buildDataRows(TimetableState state, double cellHeight) {
    return List.generate(state.maxPeriods, (rowIndex) {
      final period = rowIndex + 1;
      return TableRow(
        children: [
          Center(child: Text('$period限')),
          ...weekDays.map((day) => TimetableCellWidget(
            day: day,
            period: period,
            cellHeight: cellHeight,
            registeredClass: state.classes['$day-$period'],
          )),
        ],
      );
    });
  }
}

class TimetableCellWidget extends ConsumerWidget {
  final String day;
  final int period;
  final double cellHeight;
  final TimetableInfo? registeredClass;

  const TimetableCellWidget({super.key, required this.day, required this.period, required this.cellHeight, this.registeredClass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClassSelectionScreen(day: day, period: period),
        ));
        if (result == 'REMOVE') {
          ref.read(timetableProvider.notifier).removeClass(day, period);
        } else if (result is TimetableInfo) {
          ref.read(timetableProvider.notifier).setClass(day, period, result);
        }
      },
      child: Container(
        height: cellHeight,
        color: registeredClass != null ? Colors.blue.shade50 : null,
        child: Center(child: Text(registeredClass?.name ?? '未登録', style: const TextStyle(fontSize: 10), textAlign: TextAlign.center)),
      ),
    );
  }
}