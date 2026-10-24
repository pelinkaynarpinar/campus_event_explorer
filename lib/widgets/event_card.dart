import 'package:flutter/material.dart';

import '../models/campus_event.dart';
import '../utils/event_format.dart';

/// Reusable StatelessWidget: identical event cards in all three tabs.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onFavoritePressed,
    required this.onOpenDetails,
  });

  final CampusEvent event;
  final VoidCallback onFavoritePressed;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF18233A);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onOpenDetails,
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(event.imagePath, fit: BoxFit.cover),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: _CategoryPill(category: event.category),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: event.isFavorite
                            ? 'Remove from favorites'
                            : 'Add to favorites',
                        icon: Icon(
                          event.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: event.isFavorite
                              ? const Color(0xFFD94F68)
                              : ink,
                        ),
                        onPressed: onFavoritePressed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  icon: Icons.calendar_month_outlined,
                  value: formatEventDate(event.dateTime),
                ),
                const SizedBox(height: 6),
                _InfoRow(icon: Icons.place_outlined, value: event.venue),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _AvailabilityPill(event: event),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onOpenDetails,
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('View details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.category});
  final String category;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF17243C).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 1.25,
            ),
          ),
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.value});
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6E7A88)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF526073),
              ),
            ),
          ),
        ],
      );
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill({required this.event});
  final CampusEvent event;

  @override
  Widget build(BuildContext context) {
    final full = event.isFull;
    final color = full ? const Color(0xFFAD3851) : const Color(0xFF18725F);
    final bg = full ? const Color(0xFFFDEAF0) : const Color(0xFFE6F7EE);
    final label = full ? 'Full' : '${event.availablePlaces} places left';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(full ? Icons.block : Icons.check_circle_outline, size: 14, color: color),
            const SizedBox(width: 5),
            Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
