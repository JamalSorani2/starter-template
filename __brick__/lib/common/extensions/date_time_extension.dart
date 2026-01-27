import '../imports/imports.dart';

DateFormat kDateFormat = DateFormat('dd/MM/yyyy', 'en');

extension DateTimeX on DateTime {
  /// Format: 2025-12-25
  String get yMd => DateFormat('yyyy-MM-dd', 'en').format(this);

  /// Format: 25/12/2025
  String get dMy => DateFormat('dd/MM/yyyy', 'en').format(this);

  /// Format: 25 Dec 2025
  String get dMMMy => DateFormat('dd MMM yyyy', 'en').format(this);

  /// Format: Dec 25, 2025
  String get MMMdY => DateFormat('MMM d, yyyy', 'en').format(this);

  /// Format: 14:30
  String get hm => DateFormat('HH:mm', 'en').format(this);

  /// Format: 2:30 PM
  String get hma => DateFormat('h:mm a', 'en').format(this);

  /// Format: 25 Dec 2025, 14:30
  String get dMMMyHm => DateFormat('dd MMM yyyy, HH:mm', 'en').format(this);

  /// Format: 25 Dec 2025, 2:30 PM
  String get dMMMyHma => DateFormat('dd MMM yyyy, h:mm a', 'en').format(this);

  /// Returns true if this DateTime is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if this DateTime is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Returns true if this DateTime is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }


  /// Returns format: 25 Dec 2025
  String get dMMMyY => DateFormat('dd MMM yyyy').format(this);

  /// Returns ISO 8601 string: 2025-12-25T14:30:00
  String get iso8601 => toIso8601String();
}

extension DateTimeRangeFormatter on DateTimeRange {
  String formatDateRange() {
    final String startDate = DateFormat('yyyy/M/dd', 'en').format(start);
    final String endDate = DateFormat('yyyy/M/dd', 'en').format(end);

    return "$startDate  -  $endDate";
  }
}

bool isWeekdayInRange(int weekday, int start, int end) {
  if (start <= end) {
    return weekday >= start && weekday <= end;
  }

  // نطاق متقاطع (مثال: الجمعة → الاثنين)
  return weekday >= start || weekday <= end;
}
