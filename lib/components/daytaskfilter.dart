import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

WeekDay getWeekDay(int day) {
  switch (day) {
    case 1:
      return WeekDay.monday;
    case 2:
      return WeekDay.tuesday;
    case 3:
      return WeekDay.wednesday;
    case 4:
      return WeekDay.thursday;
    case 5:
      return WeekDay.friday;
    case 6:
      return WeekDay.saturday;
    case 7:
      return WeekDay.sunday;
    default:
      return WeekDay.monday;
  }
}

class DayTasksFilter extends StatefulWidget {
  const DayTasksFilter({super.key});

  @override
  State<DayTasksFilter> createState() => _DayTasksFilterState();
}

class _DayTasksFilterState extends State<DayTasksFilter> {
  WeekDay calendarView = getWeekDay(DateTime.now().weekday);
  final todaysWeekday = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    return SegmentedButton<WeekDay>(
      selectedIcon: const Icon(Icons.circle_outlined),
      segments: <ButtonSegment<WeekDay>>[
        ButtonSegment<WeekDay>(
          value: WeekDay.monday,
          label: const Text('M'),
          icon: todaysWeekday == 1 ? const Icon(Icons.today) : null,
        ),
        ButtonSegment<WeekDay>(
            value: WeekDay.tuesday,
            label: const Text('T'),
            icon: todaysWeekday == 2 ? const Icon(Icons.today) : null),
        ButtonSegment<WeekDay>(
            value: WeekDay.wednesday,
            label: const Text('W'),
            icon: todaysWeekday == 3 ? const Icon(Icons.today) : null),
        ButtonSegment<WeekDay>(
            value: WeekDay.thursday,
            label: const Text('T'),
            icon: todaysWeekday == 4 ? const Icon(Icons.today) : null),
        ButtonSegment<WeekDay>(
            value: WeekDay.friday,
            label: const Text('F'),
            icon: todaysWeekday == 5 ? const Icon(Icons.today) : null),
        ButtonSegment<WeekDay>(
            value: WeekDay.saturday,
            label: const Text('S'),
            icon: todaysWeekday == 6 ? const Icon(Icons.today) : null),
        ButtonSegment<WeekDay>(
            value: WeekDay.sunday,
            label: const Text('S'),
            icon: todaysWeekday == 7 ? const Icon(Icons.today) : null),
      ],
      selected: <WeekDay>{calendarView},
      onSelectionChanged: (Set<WeekDay> newSelection) {
        setState(() {
          state.setDayFilter(newSelection.first.index + 1);
          calendarView = newSelection.first;
        });
      },
    );
  }
}
