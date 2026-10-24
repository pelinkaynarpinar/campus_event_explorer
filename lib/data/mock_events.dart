import '../models/campus_event.dart';

/// Original fictional events. All dates are after the assignment deadline.
List<CampusEvent> makeMockEvents() => [
  CampusEvent(
    id: 'TECH-101',
    title: 'AI & Robotics Showcase',
    category: 'Technology',
    dateTime: DateTime(2026, 11, 3, 14, 30),
    venue: 'Engineering Faculty, Auditorium A',
    description: 'Explore student-built robots, live demos, and practical AI projects. '
        'Meet the teams, ask questions, and vote for the most inventive prototype.',
    imagePath: 'assets/images/technology.png',
    capacity: 80,
    availablePlaces: 24,
  ),
  CampusEvent(
    id: 'ART-201',
    title: 'Campus Art Night',
    category: 'Arts',
    dateTime: DateTime(2026, 11, 5, 18, 0),
    venue: 'Student Center, Exhibition Hall',
    description: 'An evening of illustration, photography, and live sketching '
        'by students. Discover original pieces and share ideas with artists.',
    imagePath: 'assets/images/arts.png',
    capacity: 45,
    availablePlaces: 0, // Required: initially full.
  ),
  CampusEvent(
    id: 'SPT-301',
    title: '3x3 Basketball Tournament',
    category: 'Sports',
    dateTime: DateTime(2026, 11, 7, 10, 0),
    venue: 'Campus Outdoor Courts',
    description: 'Join the all-level campus basketball meet-up. Watch short '
        'matches, warm up with the crowd, and cheer on student teams.',
    imagePath: 'assets/images/sports.png',
    capacity: 32,
    availablePlaces: 1, // Required: exactly one remaining place.
  ),
  CampusEvent(
    id: 'TECH-102',
    title: 'Flutter Build Lab',
    category: 'Technology',
    dateTime: DateTime(2026, 11, 9, 13, 0),
    venue: 'Computer Lab B204',
    description: 'Build a tiny mobile interface with other students. '
        'Bring your laptop; beginners are welcome and sample projects are provided.',
    imagePath: 'assets/images/technology.png',
    capacity: 40,
    availablePlaces: 12,
  ),
  CampusEvent(
    id: 'ART-202',
    title: 'Acoustic Open Mic',
    category: 'Arts',
    dateTime: DateTime(2026, 11, 12, 19, 30),
    venue: 'Campus Cafe Stage',
    description: 'A friendly night of unplugged performances, poetry, and '
        'student songwriting. Perform or enjoy the music as an audience member.',
    imagePath: 'assets/images/arts.png',
    capacity: 60,
    availablePlaces: 17,
  ),
  CampusEvent(
    id: 'SPT-302',
    title: 'Morning Yoga on the Lawn',
    category: 'Sports',
    dateTime: DateTime(2026, 11, 14, 9, 0),
    venue: 'Central Campus Lawn',
    description: 'Start the weekend with a relaxed guided stretching and '
        'movement session. Wear comfortable clothes and bring a mat.',
    imagePath: 'assets/images/sports.png',
    capacity: 35,
    availablePlaces: 9,
  ),
  CampusEvent(
    id: 'TECH-103',
    title: 'Cybersecurity Capture the Flag',
    category: 'Technology',
    dateTime: DateTime(2026, 11, 17, 15, 0),
    venue: 'Innovation Hub, Room 3',
    description: 'Solve beginner-friendly security puzzles in small teams. '
        'Topics include web security, cryptography, and investigation.',
    imagePath: 'assets/images/technology.png',
    capacity: 36,
    availablePlaces: 8,
  ),
  CampusEvent(
    id: 'ART-203',
    title: 'Creative Photography Walk',
    category: 'Arts',
    dateTime: DateTime(2026, 11, 20, 16, 0),
    venue: 'Library Main Entrance',
    description: 'Find unexpected compositions around campus on a guided '
        'photo walk. A phone camera is enough; all skill levels are invited.',
    imagePath: 'assets/images/arts.png',
    capacity: 25,
    availablePlaces: 6,
  ),
];
