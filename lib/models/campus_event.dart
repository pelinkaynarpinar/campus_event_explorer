/// A fictional campus event held in memory for a single app session.
class CampusEvent {
  CampusEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.dateTime,
    required this.venue,
    required this.description,
    required this.imagePath,
    required this.capacity,
    required this.availablePlaces,
    this.isFavorite = false,
    this.isJoined = false,
  }) : assert(capacity > 0),
       assert(availablePlaces >= 0 && availablePlaces <= capacity);

  final String id;
  final String title;
  final String category;
  final DateTime dateTime;
  final String venue;
  final String description;
  final String imagePath;
  final int capacity;
  int availablePlaces;
  bool isFavorite;
  bool isJoined;

  bool get isFull => availablePlaces == 0;

  /// Returns false if already joined or no seats remain.
  bool join() {
    if (isJoined || isFull) return false;
    isJoined = true;
    availablePlaces -= 1;
    return true;
  }

  /// A joined user may cancel even if the event currently appears full.
  bool cancel() {
    if (!isJoined) return false;
    isJoined = false;
    availablePlaces += 1;
    assert(availablePlaces <= capacity);
    return true;
  }

  void toggleFavorite() => isFavorite = !isFavorite;
}
