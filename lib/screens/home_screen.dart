import 'package:flutter/material.dart';

import '../data/mock_events.dart';
import '../models/campus_event.dart';
import '../utils/event_format.dart';
import '../widgets/event_card.dart';
import 'event_details_screen.dart';

/// One StatefulWidget owns the session's mutable event list and filter state.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CampusEvent> _events = makeMockEvents();
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _category = 'All';
  String _search = '';

  int get _joinedCount => _events.where((event) => event.isJoined).length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(CampusEvent event) {
    setState(event.toggleFavorite);
  }

  void _openDetails(CampusEvent event) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EventDetailsScreen(
          event: event,
          onFavoritePressed: () => _toggleFavorite(event),
          onJoinConfirmed: () {
            final success = event.join();
            if (success && mounted) setState(() {});
            return success;
          },
          onCancelConfirmed: () {
            final success = event.cancel();
            if (success && mounted) setState(() {});
            return success;
          },
        ),
      ),
    );
  }

  List<CampusEvent> get _visibleEvents {
    Iterable<CampusEvent> source = _events;
    if (_selectedTab == 1) {
      source = source.where((event) => event.isFavorite);
    } else if (_selectedTab == 2) {
      source = source.where((event) => event.isJoined);
    }
    return matchingEvents(source, search: _search, category: _category);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _search = '');
  }

  String get _emptyTitle {
    if (_search.trim().isNotEmpty || _category != 'All') {
      return 'No matching events';
    }
    switch (_selectedTab) {
      case 1:
        return 'No favorites yet';
      case 2:
        return 'No events joined yet';
      default:
        return 'No events found';
    }
  }

  String get _emptyBody {
    if (_search.trim().isNotEmpty || _category != 'All') {
      return 'Try a different title or category to find more events.';
    }
    switch (_selectedTab) {
      case 1:
        return 'Tap the heart on an event to save it here.';
      case 2:
        return 'Join an event to see your participation here.';
      default:
        return 'Check back for upcoming campus activities.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleEvents;
    final headerTitle = switch (_selectedTab) {
      1 => 'Your favorites',
      2 => 'My events',
      _ => 'Find your next thing.',
    };
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF176A65),
              foregroundColor: Colors.white,
              child: Icon(Icons.explore_rounded),
            ),
            SizedBox(width: 11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CAMPUS', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: 2)),
                Text('EVENT EXPLORER', style: TextStyle(fontSize: 10, letterSpacing: 2.4, color: Color(0xFF667484))),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Tooltip(
                message: 'Total joined events',
                child: Chip(
                  avatar: const Icon(Icons.confirmation_number_outlined, size: 17),
                  label: Text('$_joinedCount joined'),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 13, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: Color(0xFF18233A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Discover what is happening around campus.',
                    style: TextStyle(color: Color(0xFF657182), fontSize: 13),
                  ),
                  const SizedBox(height: 17),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _search = value),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search events by title',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _search.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: _clearSearch,
                              icon: const Icon(Icons.close_rounded),
                            ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            SizedBox(
              height: 45,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 9),
                itemBuilder: (context, index) {
                  final value = categories[index];
                  return ChoiceChip(
                    label: Text(value),
                    selected: _category == value,
                    onSelected: (_) => setState(() => _category = value),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _category == value ? Colors.white : const Color(0xFF4F5A68),
                    ),
                    selectedColor: const Color(0xFF176A65),
                    showCheckmark: false,
                    side: const BorderSide(color: Color(0xFFE1E7E9)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                children: [
                  Text(
                    '${visible.length} ${visible.length == 1 ? 'event' : 'events'} found',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF526073),
                    ),
                  ),
                  const Spacer(),
                  if (_search.trim().isNotEmpty || _category != 'All')
                    TextButton(
                      onPressed: () {
                        _clearSearch();
                        setState(() => _category = 'All');
                      },
                      child: const Text('Reset filters'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: visible.isEmpty
                  ? _EmptyState(
                      title: _emptyTitle,
                      message: _emptyBody,
                      onClear: _search.trim().isNotEmpty ? _clearSearch : null,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                      itemCount: visible.length,
                      itemBuilder: (context, index) {
                        final event = visible[index];
                        return EventCard(
                          key: ValueKey(event.id),
                          event: event,
                          onFavoritePressed: () => _toggleFavorite(event),
                          onOpenDetails: () => _openDetails(event),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note_rounded),
            label: 'My Events',
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.message, this.onClear});
  final String title;
  final String message;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.event_busy_outlined, size: 62, color: Color(0xFF92A1A9)),
              const SizedBox(height: 14),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF667484))),
              if (onClear != null) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Clear search'),
                ),
              ],
            ],
          ),
        ),
      );
}
