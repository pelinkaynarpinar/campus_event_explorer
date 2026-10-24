import 'package:flutter/material.dart';

import '../models/campus_event.dart';
import '../utils/event_format.dart';
import 'image_viewer_screen.dart';

/// Local session state is owned by HomeScreen. This screen asks it to perform
/// mutations and rebuilds itself after a successful action.
class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.onFavoritePressed,
    required this.onJoinConfirmed,
    required this.onCancelConfirmed,
  });

  final CampusEvent event;
  final VoidCallback onFavoritePressed;
  final bool Function() onJoinConfirmed;
  final bool Function() onCancelConfirmed;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _busy = false;

  Future<void> _confirmParticipation() async {
    if (_busy) return;
    final event = widget.event;
    if (!event.isJoined && event.isFull) return;

    final cancel = event.isJoined;
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(cancel ? 'Cancel participation?' : 'Join this event?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text('Date & time: ${formatEventDate(event.dateTime)}'),
            const SizedBox(height: 6),
            Text('Venue: ${event.venue}'),
            const SizedBox(height: 12),
            Text(cancel
                ? 'Your spot will become available to another student.'
                : 'One available place will be reserved for you.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (!mounted || accepted != true) return;
    setState(() => _busy = true);
    final successful = cancel
        ? widget.onCancelConfirmed()
        : widget.onJoinConfirmed();
    if (!mounted) return;
    setState(() => _busy = false);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successful
            ? (cancel ? 'Participation cancelled.' : 'You joined ${event.title}!')
            : 'The event could not be updated.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    const ink = Color(0xFF18233A);
    const green = Color(0xFF116B66);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event details'),
        actions: [
          IconButton(
            tooltip: event.isFavorite ? 'Remove favorite' : 'Add favorite',
            onPressed: () {
              widget.onFavoritePressed();
              setState(() {});
            },
            icon: Icon(
              event.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: event.isFavorite ? const Color(0xFFD94F68) : ink,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onDoubleTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => ImageViewerScreen(
                      imagePath: event.imagePath,
                      title: event.title,
                    ),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: Image.asset(event.imagePath, fit: BoxFit.cover),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF17243C).withValues(alpha: .85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.zoom_in_rounded, color: Colors.white, size: 16),
                          SizedBox(width: 6),
                          Text('Double-tap to enlarge',
                              style: TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(event.category.toUpperCase(),
                style: const TextStyle(
                  color: green,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                )),
            const SizedBox(height: 7),
            Text(event.title,
                style: const TextStyle(fontSize: 28, height: 1.15, fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 20),
            _InfoTile(icon: Icons.calendar_month_rounded, title: 'DATE & TIME',
                value: formatEventDate(event.dateTime)),
            const SizedBox(height: 12),
            _InfoTile(icon: Icons.place_rounded, title: 'VENUE', value: event.venue),
            const SizedBox(height: 12),
            _InfoTile(icon: Icons.confirmation_number_outlined, title: 'EVENT ID', value: event.id),
            const SizedBox(height: 22),
            const Text('About this event',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 10),
            Text(event.description,
                style: const TextStyle(height: 1.5, fontSize: 15, color: Color(0xFF526073))),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: event.isFull ? const Color(0xFFFCECF0) : const Color(0xFFE7F5F1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.isFull ? 'Full' : '${event.availablePlaces} places available',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: event.isFull ? const Color(0xFFA93350) : green,
                      )),
                  const SizedBox(height: 6),
                  Text('Total capacity: ${event.capacity} • Remaining: ${event.availablePlaces}',
                      style: const TextStyle(fontSize: 13, color: ink)),
                  if (event.isJoined) ...[
                    const SizedBox(height: 6),
                    const Text('You have joined this event.',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: green)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: _busy || (!event.isJoined && event.isFull)
                    ? null
                    : _confirmParticipation,
                icon: Icon(event.isJoined ? Icons.event_busy_rounded : Icons.check_circle_outline_rounded),
                label: Text(event.isJoined
                    ? 'Cancel participation'
                    : event.isFull
                        ? 'Full • No places available'
                        : 'Join event'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: const Color(0xFF116B66)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
                    letterSpacing: 1, color: Color(0xFF7B8792))),
                const SizedBox(height: 5),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      );
}
