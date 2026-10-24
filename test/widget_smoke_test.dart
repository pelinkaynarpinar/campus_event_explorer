import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_event_explorer/main.dart';

void main() {
  testWidgets('opens Explore and displays the event search UI', (tester) async {
    await tester.pumpWidget(const CampusEventExplorerApp());
    expect(find.text('Find your next thing.'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('8 events found'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
