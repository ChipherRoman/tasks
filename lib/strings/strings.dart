class SystemStrings {
  static const String appName = 'Organize.me';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Organize.me is a simple task manager app.';
  static const String appCopyRight = '© 2023 Rynalde Gabriel Silva Serejo';

  static const String taskViewBottomText =
      'Here are your tasks for today. Remember to try your best and that\'s okay to fail sometimes. Tomorrow is a new day!';

  // enum with weekdays
  static const List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  static const String today = 'Today';
  static const String tomorrow = 'Tomorrow';
  static const String yesterday = 'Yesterday';

  static String getWeekday(int day) {
    final isToday = DateTime.now().weekday == day;
    final isTomorrow = DateTime.now().weekday == day - 1;
    final isYesterday = DateTime.now().weekday == day + 1;
    if (isToday) {
      return today;
    } else if (isTomorrow) {
      return tomorrow;
    } else if (isYesterday) {
      return yesterday;
    } else {
      return weekdays[day - 1];
    }
  }
}
