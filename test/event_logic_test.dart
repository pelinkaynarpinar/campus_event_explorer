import 'package:flutter_test/flutter_test.dart';
import 'package:campus_event_explorer/data/mock_events.dart';
import 'package:campus_event_explorer/models/campus_event.dart';
import 'package:campus_event_explorer/utils/event_format.dart';

void main() {
  test('fixture has eight valid events, three categories, a full event and one seat', () {
    final events = makeMockEvents();
    expect(events.length, greaterThanOrEqualTo(6));
    expect(events.map((e) => e.id).toSet().length, events.length);
    expect(events.map((e) => e.category).toSet().length, greaterThanOrEqualTo(3));
    expect(events.any((e) => e.availablePlaces == 0), isTrue);
    expect(events.any((e) => e.availablePlaces == 1), isTrue);
    for (final e in events) {
      expect(e.dateTime.isAfter(DateTime(2026, 10, 25, 23, 59)), isTrue);
      expect(e.availablePlaces, inInclusiveRange(0, e.capacity));
    }
  });

  test('a student cannot join the same event twice', () {
    final event = CampusEvent(
      id: 'T1', title: 'Test', category: 'Technology',
      dateTime: DateTime(2026, 11, 1), venue: 'Campus',
      description: 'Fixture', imagePath: 'assets/images/technology.png',
      capacity: 4, availablePlaces: 2,
    );
    expect(event.join(), isTrue);
    expect(event.join(), isFalse);
    expect(event.availablePlaces, 1);
    expect(event.cancel(), isTrue);
    expect(event.cancel(), isFalse);
    expect(event.availablePlaces, 2);
  });

  test('a full event cannot be joined, but a joined last seat can cancel', () {
    final full = makeMockEvents().firstWhere((e) => e.availablePlaces == 0);
    expect(full.join(), isFalse);
    expect(full.availablePlaces, 0);
    final last = makeMockEvents().firstWhere((e) => e.availablePlaces == 1);
    expect(last.join(), isTrue);
    expect(last.isFull, isTrue);
    expect(last.cancel(), isTrue);
    expect(last.availablePlaces, 1);
  });

  test('favorites are independent of seats and joining', () {
    final event = makeMockEvents().first;
    final before = event.availablePlaces;
    event.toggleFavorite();
    expect(event.isFavorite, isTrue);
    expect(event.isJoined, isFalse);
    expect(event.availablePlaces, before);
  });

  test('trimmed case-insensitive title and category filters combine', () {
    final events = makeMockEvents();
    final filtered = matchingEvents(events,
        search: '  fLuTtEr  ', category: 'Technology');
    expect(filtered.map((e) => e.title).toList(), ['Flutter Build Lab']);
    expect(matchingEvents(events, search: 'flutter', category: 'Sports'), isEmpty);
    expect(matchingEvents(events, search: 'not-a-real-event', category: 'All'), isEmpty);
  });
}
