import 'package:intl/intl.dart';
import '../imports/imports.dart';

extension DateTimeX on DateTime {
  /// Format: 2025-12-25
  String get yMd => DateFormat('yyyy-MM-dd').format(this);

  /// Format: 25/12/2025
  String get dMy => DateFormat('dd/MM/yyyy').format(this);

  /// Format: 25 Dec 2025
  String get dMMMy => DateFormat('dd MMM yyyy').format(this);

  /// Format: Dec 25, 2025
  String get MMMdY => DateFormat('MMM d, yyyy').format(this);

  /// Format: 14:30
  String get hm => DateFormat('HH:mm').format(this);

  /// Format: 2:30 PM
  String get hma => DateFormat('h:mm a').format(this);

  /// Format: 25 Dec 2025, 14:30
  String get dMMMyHm => DateFormat('dd MMM yyyy, HH:mm').format(this);

  /// Format: 25 Dec 2025, 2:30 PM
  String get dMMMyHma => DateFormat('dd MMM yyyy, h:mm a').format(this);

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

  /// Returns a human-readable "time ago" string
  String timeAgo() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return 'just now';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    }
    return dMMMyY; // fallback format
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
