import '../models/campus_event.dart';

const categories = <String>['All', 'Technology', 'Arts', 'Sports'];

const _months = <String>[
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatEventDate(DateTime dateTime) {
  final month = _months[dateTime.month - 1];
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return '$month $day, ${dateTime.year} • $hour:$minute';
}

/// Both title and query are trimmed and case-insensitive; category combines
/// with title as an AND filter. All tabs reuse this very same helper.
List<CampusEvent> matchingEvents(
  Iterable<CampusEvent> events, {
  required String search,
  required String category,
}) {
  final query = search.trim().toLowerCase();
  return events.where((event) {
    final matchesTitle = event.title.toLowerCase().contains(query);
    final matchesCategory = category == 'All' || event.category == category;
    return matchesTitle && matchesCategory;
  }).toList();
}
